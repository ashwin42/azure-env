terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//800xA_vm?ref=v0.2.8"
  #source = "../modules/800xA_vm"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name                    = "FLSP001"
  ipaddress               = "10.60.60.49"
  nic0_name_alt           = "flsp001675"
  nsg0_name_alt           = "FLSP001nsg724"
  public_ip               = true
  vm_size                 = "Standard_B2MS"
  resource_group_name     = dependency.global.outputs.resource_group.name
  resource_group_name_alt = dependency.global.outputs.resource_group.name
  resource_group_name_vm  = "800XA"
  subnet_id               = dependency.global.outputs.subnet_2.id
  default_tags            = { repo = "azure-env/nv-production/800xa/flsp001" }
  os_disk_create_option   = "FromImage"
  managed_disk_name       = "_OsDisk_1_567ff8c634544453a2d89f782cc481c7"
  managed_disk_type       = "Premium_LRS"
  data_disks = [
    {
      name                 = "_DataDisk_0"
      size                 = "256"
      lun                  = "0"
      storage_account_type = "Premium_LRS"
    }
  ]
  os_profile = {
    map = {
      admin_username = "Sharepoint"
      computer_name  = "FLSP001"
    }
  }
  os_profile_windows_config = {
    map = {
      enable_automatic_upgrades = true
      provision_vm_agent        = true
      timezone                  = ""
    }
  }
  backup_vm                              = true
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
}

