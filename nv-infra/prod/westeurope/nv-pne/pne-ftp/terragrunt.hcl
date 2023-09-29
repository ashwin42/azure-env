terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.15"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  vm_name                                = "${basename(dirname(get_parent_terragrunt_dir()))}"
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  subnet_id                              = dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id
  vm_name                                = "pne-ftp"
  vm_size                                = "Standard_DS1_v2"
  managed_disk_name                      = "pne-ftp-osdisk"
  managed_disk_type                      = "StandardSSD_LRS"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "pne-ftp-nvadmin"
  nsg0_name_alt                          = "pne-ftp-nsg"
  storage_account_name                   = "nvinfrabootdiag"
  data_disks = [
    {
      name                 = "pne-ftp-datadisk"
      size                 = "30"
      lun                  = "1"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  storage_image_reference = {
    offer     = include.root.locals.all_vars.ubuntu_offer,
    publisher = include.root.locals.all_vars.ubuntu_publisher,
    sku       = include.root.locals.all_vars.ubuntu_sku,
  }
  network_interfaces = [
    {
      name      = "pne-ftp-nic1"
      ipaddress = "10.44.5.62"
      subnet    = dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id
      public_ip = false
    }
  ],
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
    },
    {
      name                  = "Local_VNET"
      priority              = "230"
      direction             = "Inbound"
      source_address_prefix = "10.44.5.32/27"
      access                = "Allow"
      description           = "Allow connections from local VNET"
    }
  ]
}

