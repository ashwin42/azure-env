terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.16"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  setup_prefix                           = "asrs-wcs-dev"
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_size                                = "Standard_B4ms"
  backup_vm                              = false
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "asrs-wcs-dev-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = "true"
  storage_image_reference = {
    sku = "2016-Datacenter",
  }
  os_profile_windows_config = {
  }
  network_interfaces = [
    {
      name      = "asrs-wcs-dev-nic1"
      ipaddress = "10.44.5.181"
      subnet    = dependency.global.outputs.subnet["asrs-nv1-dev-subnet-10.44.5.176-28"].id
      public_ip = false
      private_ip_address_allocation = "Static"
    }
  ]
  data_disks = [
    {
      name                 = "asrs-wcs-dev-data1"
      size                 = "20"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
    {
      name                 = "asrs-wcs-dev-data2"
      size                 = "40"
      lun                  = "6"
      storage_account_type = "StandardSSD_LRS"
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
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.global.outputs.subnet["asrs-nv1-dev-subnet-10.44.5.176-28"].address_prefix
      access                = "Allow"
      description           = "Allow connections from local subnet"
    },
    {
      name                   = "LocalSubnetWeb"
      priority               = "210"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-dev-subnet-10.44.5.192-28"].address_prefix
      protocol               = "Tcp"
      destination_port_range = "4711"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                  = "D365_API_Mgmt"
      priority              = "215"
      direction             = "Inbound"
      source_address_prefix = "10.44.6.0/25"
      access                = "Allow"
      description           = "Allow connections from API Mgmt service"
    },
  ]
}
