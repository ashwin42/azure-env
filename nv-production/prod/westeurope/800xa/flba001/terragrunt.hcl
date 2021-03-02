terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//800xA_vm?ref=v0.2.8"
  #source = "../modules/800xA_vm"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name                                   = "FLBA001"
  ipaddress                              = "10.60.60.7"
  ipaddress2                             = "10.60.50.7"
  ipaddress3                             = "10.60.51.7"
  vm_size                                = "Standard_B2MS"
  resource_group_name_vm                 = dependency.global.outputs.resource_group.name
  resource_group_name                    = dependency.global.outputs.resource_group.name
  resource_group_name_alt                = "800XA"
  subnet_id                              = dependency.global.outputs.subnet_2.id
  subnet_id2                             = dependency.global.outputs.subnet_1.id
  subnet_id3                             = dependency.global.outputs.subnet_3.id
  default_tags                           = { repo = "azure-env/nv-production/800xa/flba001" }
  os_disk_create_option                  = "FromImage"
  managed_disk_name                      = "_OsDisk_1_a12ee5214cef4626ad4efcfb405d5707"
  managed_disk_type                      = "Premium_LRS"
  backup_vm                              = true
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  storage_image_reference = {
    map = {
      id = "/subscriptions/9e74ee1a-13dd-486f-be8a-5caa55fb5742/resourceGroups/xAPG-AzNV-Cloud-Lab/providers/Microsoft.Compute/galleries/ABB_Shared_Image_Gallery/images/Windows2016-800xA61-NonNPT/versions/1.0.0"
    }
  }
  os_profile = {
    map = {
      admin_username = "localadmin"
      computer_name  = "FLBA001"
    }
  }
  os_profile_windows_config = {
    map = {
      enable_automatic_upgrades = false
      provision_vm_agent        = true
      timezone                  = ""
    }
  }
}

