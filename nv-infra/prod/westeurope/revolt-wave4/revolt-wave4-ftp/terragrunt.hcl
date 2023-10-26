terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.15"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  setup_prefix                           = "${dependency.global.outputs.setup_prefix}-ftp"
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_size                                = "Standard_DS1_v2"
  managed_disk_type                      = "StandardSSD_LRS"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "revolt-wave4-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  data_disks = [
    {
      name                 = "revolt-wave4-ftp-datadisk"
      size                 = "30"
      lun                  = "1"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  storage_image_reference = {
    offer     = include.root.locals.all_vars.ubuntu_offer_minimal_20,
    publisher = include.root.locals.all_vars.ubuntu_publisher,
    sku       = include.root.locals.all_vars.ubuntu_sku_minimal_20,
  }
  network_interfaces = [
    {
      name      = "revolt-wave4-ftp-nic1"
      ipaddress = "10.44.5.151"
      subnet    = dependency.global.outputs.subnet["revolt-wave4-subnet-10.44.5.144-28"].id
      public_ip = false
    }
  ],
  dns_servers = null
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
      name                  = "Local_VNET"
      priority              = "230"
      direction             = "Inbound"
      source_address_prefix = dependency.global.outputs.subnet["revolt-wave4-subnet-10.44.5.144-28"].address_prefix
      access                = "Allow"
      description           = "Allow connections from local VNET"
    }
  ]
}

