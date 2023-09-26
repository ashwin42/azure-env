terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../vnet"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

inputs = {
  netbox_role                            = "asrs"
  setup_prefix                           = "asrs-wcs-prod"
  vm_name                                = "asrs-wcs-prod"
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_D4s_v3"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "asrs-wcs-prod-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = "true"
  install_winrm                          = true
  storage_image_reference = {
    sku = "2016-Datacenter-smalldisk",
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
  }
  ipconfig_name = "asrs-wcs-prod-nic1-ipconfig"
  network_interfaces = [
    {
      primary             = true
      security_group_name = "asrs-wcs-prod-vm-nsg"
      name                = "asrs-wcs-prod-nic1"
      public_ip           = false
      ip_configuration = [{
        subnet_id                     = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.0-27"].id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.46.0.6"
      }]
    }
  ]
  boot_diagnostics_enabled = true
  dns_servers              = null
  managed_disk_name        = "asrs-wcs-prod-vm-osdisk"
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
      name                   = "Siemens_mgmt_wvd"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = dependency.vnet.outputs.subnets["siemens-mgmt-subnet"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow connections from Siemens Mgmt subnet"
    },
    {
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.0-27"].address_prefixes[0]
      access                = "Allow"
      description           = "Allow connections from local subnet"
    },
    {
      name                   = "LocalSubnetWebCathode"
      priority               = "210"
      direction              = "Inbound"
      source_address_prefix  = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.32-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5005"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebAnode"
      priority               = "211"
      direction              = "Inbound"
      source_address_prefix  = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.48-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5006"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebcw1"
      priority               = "212"
      direction              = "Inbound"
      source_address_prefix  = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.80-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5007"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebfa1"
      priority               = "213"
      direction              = "Inbound"
      source_address_prefix  = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.96-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5008"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebspw"
      priority               = "214"
      direction              = "Inbound"
      source_address_prefix  = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.112-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5009"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "D365_API_Mgmt"
      priority               = "215"
      direction              = "Inbound"
      source_address_prefix  = "10.44.6.0/25"
      protocol               = "Tcp"
      destination_port_range = "5005-5020"
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
      protocol               = "Tcp"
      destination_port_range = "5005-5020"
      access                 = "Allow"
      description            = "Allow connections from API Mgmt service"
    },
    {
      name                   = "ICMP"
      priority               = "223"
      direction              = "Inbound"
      source_address_prefix  = "10.0.0.0/8"
      protocol               = "Icmp"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow ICMP"
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
    {
      name                   = "AWS_Ett_DS1_Stockholm_Prod"
      priority               = "230"
      direction              = "Inbound"
      source_address_prefix  = "10.22.76.0/22"
      protocol               = "Tcp"
      destination_port_range = "5005-5020"
      access                 = "Allow"
      description            = "Allow connections from API Mgmt service"
    },
    {
      name                   = "LocalSubnetWebCathode2"
      priority               = "240"
      direction              = "Inbound"
      source_address_prefix  = dependency.vnet.outputs.subnets["cathode2-web-app-subnet"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5005,5011"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebAnode2"
      priority               = "241"
      direction              = "Inbound"
      source_address_prefix  = dependency.vnet.outputs.subnets["anode2-web-app-subnet"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5006,5010"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "AWS_Ett_ASRS_Automation_CIDR1"
      priority               = "250"
      direction              = "Inbound"
      source_address_prefix  = "10.21.13.0/24"
      protocol               = "Tcp"
      destination_port_range = "5000-5020"
      access                 = "Allow"
      description            = "Allow connections from ASRS service at AWS Ett"
    },
    {
      name                   = "AWS_Ett_ASRS_Automation_CIDR2"
      priority               = "251"
      direction              = "Inbound"
      source_address_prefix  = "10.21.14.0/23"
      protocol               = "Tcp"
      destination_port_range = "5000-5020"
      access                 = "Allow"
      description            = "Allow connections from ASRS service at AWS Ett"
    },
    {
      name                   = "AWS_Ett_DS1_CIDR1"
      priority               = "252"
      direction              = "Inbound"
      source_address_prefix  = "10.22.76.0/23"
      protocol               = "Tcp"
      destination_port_range = "5000-5020"
      access                 = "Allow"
      description            = "Allow connections from ASRS service at AWS Ett DS1"
    },
    {
      name                   = "AWS_Ett_DS1_CIDR2"
      priority               = "253"
      direction              = "Inbound"
      source_address_prefix  = "10.22.78.0/24"
      protocol               = "Tcp"
      destination_port_range = "5000-5020"
      access                 = "Allow"
      description            = "Allow connections from ASRS service at AWS Ett DS1"
    },
    {
      name                    = "AWS_Ett_core"
      priority                = "254"
      direction               = "Inbound"
      source_address_prefixes = ["10.14.3.0/24", "10.14.4.0/23"]
      protocol                = "Tcp"
      destination_port_range  = "5005-5020"
      access                  = "Allow"
      description             = "Allow connections from API Mgmt service"
    },
  ]
  windows_data_collection_rule_names = ["windows_event_log-dcr"]
}

