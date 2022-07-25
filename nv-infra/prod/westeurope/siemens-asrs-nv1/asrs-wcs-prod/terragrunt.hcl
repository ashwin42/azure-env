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
  setup_prefix                           = "asrs-wcs-prod"
  vm_name                                = "asrs-wcs-prod"
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_size                                = "Standard_B4ms"
  backup_vm                              = false
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "asrs-wcs-prod-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = "true"
  storage_image_reference = {
    sku = "2016-Datacenter-smalldisk",
  }
  os_profile_windows_config = {
  }
  network_interfaces = [
    {
      name      = "asrs-wcs-prod-nic1"
      ipaddress = "10.46.0.6"
      subnet    = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].id
      public_ip = false
    }
  ]
  data_disks = [
    {
      name                 = "asrs-wcs-prod-data1"
      size                 = "20"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
    {
      name                 = "asrs-wcs-prod-data2"
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
      source_address_prefix = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].address_prefix
      access                = "Allow"
      description           = "Allow connections from local subnet"
    },
    {
      name                   = "LocalSubnetWebCathode"
      priority               = "210"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.32-28"].address_prefix
      protocol               = "TCP"
      destination_port_range = "4711,5005"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebAnode"
      priority               = "211"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.48-28"].address_prefix
      protocol               = "TCP"
      destination_port_range = "4711,5006"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebcw1"
      priority               = "212"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.80-28"].address_prefix
      protocol               = "TCP"
      destination_port_range = "4711,5007"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebfa1"
      priority               = "213"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.96-28"].address_prefix
      protocol               = "TCP"
      destination_port_range = "4711,5008"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebspw"
      priority               = "214"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.112-28"].address_prefix
      protocol               = "TCP"
      destination_port_range = "4711,5009"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "D365_API_Mgmt"
      priority               = "215"
      direction              = "Inbound"
      source_address_prefix  = "10.44.6.0/25"
      protocol               = "TCP"
      destination_port_range = "5005-5009"
      access                 = "Allow"
      description            = "Allow connections from API Mgmt service"
    },
    {
      name                  = "Ett_IT"
      priority              = "220"
      direction             = "Inbound"
      source_address_prefix = "10.103.0.0/16"
      access                = "Allow"
      description           = "Allow connections from Ett IT"
    },
    {
      name                  = "Ett_OT"
      priority              = "221"
      direction             = "Inbound"
      source_address_prefix = "10.203.0.0/16"
      access                = "Allow"
      description           = "Allow connections from Ett OT"
    },
    {
      name                   = "AWS_Automation_Ireland_Prod"
      priority               = "222"
      direction              = "Inbound"
      source_address_prefix  = "10.21.0.0/16"
      protocol               = "TCP"
      destination_port_range = "5005-5009"
      access                 = "Allow"
      description            = "Allow connections from API Mgmt service"
    },
    {
      name                   = "AWS_Automation_Ireland_Prod_ICMP"
      priority               = "223"
      direction              = "Inbound"
      source_address_prefix  = "10.21.0.0/16"
      protocol               = "ICMP"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow connections from API Mgmt service"
    },
    {
      name                   = "Ett_MFA_VPN"
      priority               = "225"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients"
    },
  ]
}

