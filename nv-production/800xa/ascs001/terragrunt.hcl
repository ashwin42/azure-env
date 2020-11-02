terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//800xA_vm?ref=v0.1.1"
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
  name                                   = "ASCS001"
  ipaddress                              = "10.60.60.48"
  ipconfig1_name                         = "ASCS001-nic_config"
  nic0_name_alt                          = "ASCS001-nic"
  nsg0_name_alt                          = "ascs001-nsg"
  dns_servers                            = ["10.0.1.4", "10.60.60.5"]
  vm_size                                = "Standard_DS3_v2"
  resource_group_name                    = dependency.global.outputs.resource_group.name
  resource_group_name_alt                = dependency.global.outputs.resource_group.name
  resource_group_name_vm                 = dependency.global.outputs.resource_group.name
  subnet_id                              = dependency.global.outputs.subnet_2.id
  default_tags                           = { repo = "azure-env/nv-production/800xa/ascs001" }
  os_disk_create_option                  = "FromImage"
  managed_disk_name                      = "-os"
  ad_join                                = true
  backup_vm                              = true
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  os_profile = {
    map = {
      admin_username = "nvadmin"
      computer_name  = "ASCS001"
    }
  }
  os_profile_windows_config = {
    map = {
      enable_automatic_upgrades = false
      provision_vm_agent        = true
      timezone                  = "W. Europe Standard Time"
    }
  }
}

