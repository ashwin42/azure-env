terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}

dependency "wvd" {
  config_path = "../avd-tc11"
}

locals {
  name = basename(get_terragrunt_dir())
  host_pool_name = "nv-pne-hp-tc11a"
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  token                                  = dependency.wvd.outputs.tokens[local.host_pool_name]
  host_pool_name                         = dependency.wvd.outputs.host_pools[local.host_pool_name].name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  loganalytics_resource_group_name       = "loganalytics-rg"
  loganalytics_workspace_id              = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/loganalytics-rg/providers/Microsoft.OperationalInsights/workspaces/log-analytics-ops-ws"
  loganalytics_subscription_id           = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  name                                   = local.name
  vm_name                                = local.name
  vm_size                                = "Standard_D8_v4"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_key_name                    = "nv-pne-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = "domainjoin"
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.44.5.44"
          subnet_id                     = dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "nv-pne-tc11a-nic-ipconfig"
        }
      ]
    }
  ]
  data_disks = [
    {
      name                 = "${local.name}-datadisk01"
      size                 = "4096"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    }
  ]
  custom_rules = [
    {
      name                  = "NV-Cyclers"
      priority              = "220"
      direction             = "Inbound"
      source_address_prefix = "10.100.250.0/23"
      access                = "Allow"
      description           = "Allow connections from NV-Cyclers"
    },
    {
      name                  = "NV-Cyclers-11a"
      priority              = "222"
      direction             = "Inbound"
      source_address_prefix = "10.149.40.0/22"
      access                = "Allow"
      description           = "Allow connections from NV-Cyclers"
    },
  ]
}

