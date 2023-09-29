terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.3.0"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../nv-octoplant/subnet"
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
    sku = local.windows_server_sku,
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
          ipaddress                     = "10.46.1.13"
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
      name                   = "Labs_MFA_VPN_RDP_3389"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                   = "nv-plc-ews_Allow_64001-64006"
      priority               = "300"
      direction              = "Inbound"
      source_address_prefix  = "10.46.1.32/28"
      protocol               = "Tcp"
      destination_port_range = "64001-64006"
      access                 = "Allow"
      description            = "Allow neccessary ports 64001-64006 from PLC Engineering Workstations subnet"
    },
    {
      name                   = "nv-plc-ews_Allow_64021"
      priority               = "301"
      direction              = "Inbound"
      source_address_prefix  = "10.46.1.32/28"
      protocol               = "Tcp"
      destination_port_range = "64021"
      access                 = "Allow"
      description            = "Allow neccessary port 64021 from PLC Engineering Workstations subnet"
    },
    {
      name                   = "Labs_MFA_VPN_80"
      priority               = "302"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "80"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients on port 80"
    },
    {
      name                   = "Labs_MFA_VPN_443"
      priority               = "303"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "443"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients on port 443"
    },
    {
      name                   = "Labs_MFA_VPN_64001-64004"
      priority               = "304"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "64001-64004"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients on ports 64001-64003"
    },
    {
      name                   = "Labs_MFA_VPN_64006"
      priority               = "305"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "64006"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients on port 64006"
    },
    {
      name                   = "Labs_MFA_VPN_64021"
      priority               = "306"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "64021"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients on port 64021"
    },
    {
      name                   = "Labs_MFA_VPN_64023"
      priority               = "307"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "64023"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients on port 64023"
    },
    {
      name                   = "Allow_ICMP_Labs"
      priority               = "202"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "Icmp"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow ICMP Echo Request"
    },
  ]
}

