include {
  path = find_in_parent_folders()
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  name                                   = local.name
  vm_name                                = local.name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  storage_account_name                   = "nvprodbootdiagswc"
  ad_join                                = true
  localadmin_key_name                    = "${local.name}-nvadmin"
  create_localadmin_password             = true

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
    admin_username = "nvadmin"
    computer_name  = local.name
  }

  data_disks = [
    {
      name                 = "${local.name}-datadisk1"
      size                 = "1090"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    }
  ]
}

