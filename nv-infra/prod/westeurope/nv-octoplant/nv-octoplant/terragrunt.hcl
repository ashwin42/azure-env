terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.3.0"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_D4_v3"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  managed_disk_size                      = 256
  storage_image_reference = {
    sku = "2019-Datacenter",
  }
  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = true
    timezone                   = null
    winrm                      = null
    additional_unattend_config = null
  }
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          ipaddress                     = "10.46.1.12"
          subnet_id                     = dependency.vnet.outputs.subnet["nv-octoplant-10.46.1.8_29"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                   = "Labs_RDP_MFA_VPN"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "Tcp"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow RDP connections from Labs MFA VPN clients"
    },
    {
      name                   = "Ett_MFA_VPN"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow RDP connections from Ett MFA VPN clients"
    },
    {
      name                   = "Ett_MFA_VPN_80"
      priority               = "300"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "80"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients on port 80"
    },
    {
      name                   = "Ett_MFA_VPN_443"
      priority               = "301"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "443"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients on port 443"
    },
    {
      name                   = "Ett_MFA_VPN_64001-64004"
      priority               = "302"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "64001-64004"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients on ports 64001-64004"
    },
    {
      name                   = "Ett_MFA_VPN_64006"
      priority               = "303"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "64006"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients on port 64006"
    },
    {
      name                   = "Ett_MFA_VPN_64021"
      priority               = "304"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "64021"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients on port 64021"
    },
    {
      name                   = "Ett_MFA_VPN_64023"
      priority               = "305"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "64023"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients"
    },
    {
      name                   = "Allow_ICMP_Ett"
      priority               = "202"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "Icmp"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow ICMP Echo Request for Ett"
    },    
  ]
}

