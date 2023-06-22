include "root" {
  path   = find_in_parent_folders()
  expose = true
}


dependency "global" {
  config_path = "../global"
}



locals {
  name    = basename(get_original_terragrunt_dir())
  vm_name = format("f1-ds1-asrs%s", replace(local.name, "bound", ""))
}

inputs = {
  vm_name                                = local.vm_name
  setup_prefix                           = local.vm_name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_size                                = "Standard_D2as_v4"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  create_localadmin_password             = true
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "${local.vm_name}-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  install_winrm                          = true
  storage_image_reference = {
    sku = "2022-Datacenter-smalldisk",
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
  }
  boot_diagnostics_enabled = true
  managed_disk_name        = "${local.vm_name}-osdisk"
  data_disks = [
    {
      name                 = "siemens-asrs-${local.vm_name}-data1"
      size                 = "50"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
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
      source_address_prefix = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].address_prefixes[0]
      access                = "Allow"
      description           = "Allow connections from local subnet"
    },
    {
      name                   = "LocalSubnetWebCathode"
      priority               = "210"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.32-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5005"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebAnode"
      priority               = "211"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.48-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5006"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebcw1"
      priority               = "212"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.80-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5007"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebfa1"
      priority               = "213"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.96-28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5008"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebspw"
      priority               = "214"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.112-28"].address_prefixes[0]
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
      source_address_prefix  = dependency.global.outputs.subnet["cathode2-web-app-subnet"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5005,5011"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetWebAnode2"
      priority               = "241"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet["anode2-web-app-subnet"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5006,5010"
      access                 = "Allow"
      description            = "Allow connections from local web delegated subnet"
    },
  ]
  windows_data_collection_rule_names = ["windows_event_log-dcr"]
}

