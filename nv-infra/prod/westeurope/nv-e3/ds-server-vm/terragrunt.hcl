terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.3.9"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  name                                   = local.name
  vm_name                                = local.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_size                                = "Standard_B2s"
  managed_disk_name                      = "${local.name}-osdisk"
  managed_disk_type                      = "StandardSSD_LRS"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "${local.name}-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  os_type                                = "Linux"
  boot_diagnostics_enabled               = true

  ad_join                                = true
  storage_image_reference = {
    offer     = "WindowsServer",
    publisher = "MicrosoftWindowsServer",
    sku       = "2019-Datacenter"
  }
  os_profile_windows_config = {
    enable_automatic_upgrades  = true
    timezone                   = "W. Europe Standard Time"
    provision_vm_agent         = true
    winrm                      = null
    additional_unattend_config = null
  }
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.44.5.134"
          subnet_id                     = dependency.global.outputs.subnet["nv-e3-subnet-10.44.5.128"].id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "300"
      lun                  = "5"
      storage_account_type = "Standard_LRS"
    }
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
      name                  = "AllowLocalSubnet"
      priority              = "220"
      direction             = "Inbound"
      source_address_prefix = dependency.global.outputs.subnet["nv-e3-subnet-10.44.5.128"].address_prefixes.0
      access                = "Allow"
      description           = "Allow connections from local subnet"
    },
  ]
}

