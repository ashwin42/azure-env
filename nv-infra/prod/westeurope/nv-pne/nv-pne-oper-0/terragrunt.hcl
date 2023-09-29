terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vm/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}

dependency "wvd" {
  config_path = "../wvd"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  token                                  = dependency.wvd.outputs.token
  host_pool_name                         = dependency.wvd.outputs.host_pool.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  loganalytics_resource_group_name       = "loganalytics-rg"
  loganalytics_workspace_id              = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/loganalytics-rg/providers/Microsoft.OperationalInsights/workspaces/log-analytics-ops-ws"
  loganalytics_subscription_id           = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  vm_name                                = "nv-pne-oper-0"
  vm_size                                = "Standard_F16"
  backup_vm                              = true
  managed_disk_name                      = "nv-pne-oper-0_OsDisk_1_5e3cecb836374e779f44e77c610cd138"
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  boot_diagnostics_enabled               = true
  storage_account_name                   = "nvinfrabootdiag"
  ipconfig_name                          = "ipconfig"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "20h1-evd",
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  os_profile = {
    admin_username = "domainjoin"
    computer_name  = "nv-pne-oper-0"
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.44.5.37"
          subnet_id                     = dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "nv-pne-oper-0-nic-ipconfig"
        }
      ]
    }
  ]

  data_disks = [
    {
      name                 = "nv-pne-oper-0_datadisk1"
      size                 = "5000"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    },
  ]

  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "NV-Cyclers"
      priority              = "220"
      direction             = "Inbound"
      source_address_prefix = "10.100.250.0/23"
      access                = "Allow"
      description           = "Allow connections from NV-Cyclers"
    }
  ]
}
