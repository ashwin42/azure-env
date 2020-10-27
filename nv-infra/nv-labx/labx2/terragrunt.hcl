terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//800xA_vm?ref=v0.1.1"
  source = "../../../../tf-mod-azure/vm"
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
  setup_prefix                           = dependency.global.outputs.setup_prefix
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = "nv_labx2"
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = "nv_labx2"
  subnet_id                              = dependency.global.outputs.subnet["10.44.2.0/26"].id
  vm_name                                = "labx2"
  managed_disk_type                      = "StandardSSD_LRS"
  managed_disk_name                      = "labx2-os"
  nsg0_name_alt                          = "nv_labx2_nsg"
  create_avset                           = "true"
  avset_name                             = "nv_labx2_avs"
  vm_size                                = "Standard_B2ms"
  backup_vm                              = false
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-labx"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = "true"
  ipconfig_name                          = "labx2-nic_config"
  storage_image_reference = {
    sku = "2016-Datacenter",
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = "false",
  }
  network_interfaces = [
    {
      name      = "labx2-nic"
      ipaddress = "10.44.2.8"
      subnet    = dependency.global.outputs.subnet["10.44.2.0/26"].id
      public_ip = false
    }
  ]
  data_disks = [
    {
      name                 = "labx2-data1"
      size                 = "25"
      lun                  = "5"
      storage_account_type = "Premium_LRS"
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
      name                  = "NV-VH_VPN"
      priority              = "210"
      direction             = "Inbound"
      source_address_prefix = "10.10.0.0/21"
      access                = "Allow"
      description           = "Allow connections from NV-VH"
    }
  ]
}
