terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.0"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  setup_prefix                           = "nv-labware"
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  subnet_id                              = dependency.global.outputs.subnet["10.44.2.0/26"].id
  vm_name                                = "labware"
  vm_size                                = "Standard_B2ms"
  backup_vm                              = false
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-labx"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = "true"
  storage_image_reference = {
    sku = "2019-Datacenter-smalldisk",
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = "true",
  }
  network_interfaces = [
    {
      name      = "labware-nic1"
      ipaddress = "10.44.2.9"
      subnet    = dependency.global.outputs.subnet["10.44.2.0/26"].id
      public_ip = false
    }
  ]
#  data_disks = [
#    {
#      name                 = "labx2-data1"
#      size                 = "25"
#      lun                  = "5"
#      storage_account_type = "StandardSSD_LRS"
#    }
#  ]
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
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.global.outputs.subnet["10.44.2.0/26"].address_prefix
      access                = "Allow"
      description           = "Allow connections from local subnet"
    }
  ]
}
