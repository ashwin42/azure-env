terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}///tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../core-network"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

generate = merge(
  include.root.locals.generate_providers.netbox,
  include.root.locals.generate_providers_version_override.netbox
)

locals {
  name = "hub-router"
}

inputs = {
  name                                   = local.name
  vm_name                                = local.name
  resource_group_name                    = dependency.vnet.outputs.virtual_network.resource_group_name
  vm_size                                = "Standard_B2s"
  managed_disk_type                      = "Standard_LRS"
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  backup_vm                              = true
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "hub-router-nvadmin"
  storage_image_reference = {
    offer     = local.ubuntu_offer,
    publisher = local.ubuntu_publisher,
    sku       = local.ubuntu_sku,
  }
  #encrypt_disks = true
  network_interfaces = [
    {
      name                 = "${local.name}-nic"
      enable_ip_forwarding = true
      ip_configuration = [
        {
          private_ip_address            = "10.40.253.5"
          subnet_id                     = dependency.vnet.outputs.subnets.hub-dmz.id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
          #public_ip_address_name        = "${local.name}-public-ip"
        },
      ]
    },
  ],
  data_collection_rule_names = ["linux_syslog-dcr"]
  custom_rules = [
    {
      name                       = "Labs_MFA_VPN"
      priority                   = "200"
      direction                  = "Inbound"
      source_address_prefix      = "10.16.8.0/23"
      destination_address_prefix = "0.0.0.0/0"
      protocol                   = "*"
      destination_port_range     = "0-65535"
      access                     = "Allow"
      description                = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                       = "Ett_MFA_VPN"
      priority                   = "201"
      direction                  = "Inbound"
      source_address_prefix      = "10.240.0.0/21"
      destination_address_prefix = "0.0.0.0/0"
      protocol                   = "*"
      destination_port_range     = "0-65535"
      access                     = "Allow"
      description                = "Allow connections from Ett MFA VPN clients"
    },
    {
      name                       = "Labs_Jumphost"
      priority                   = "202"
      direction                  = "Inbound"
      source_address_prefix      = "10.254.6.16/29"
      destination_address_prefix = "0.0.0.0/0"
      protocol                   = "*"
      destination_port_range     = "0-65535"
      access                     = "Allow"
      description                = "Allow connections from Ett MFA VPN clients"
    },
    {
      name                       = "Deny_SSH"
      priority                   = "210"
      direction                  = "Inbound"
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "10.40.253.5"
      protocol                   = "*"
      destination_port_range     = "22"
      access                     = "Deny"
      description                = "Deny All SSH"
    },
    {
      name                       = "Allow_All"
      priority                   = "220"
      direction                  = "Inbound"
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "0.0.0.0/0"
      protocol                   = "*"
      destination_port_range     = "0-65535"
      access                     = "Allow"
      description                = "Allow All Connections"
    }
  ]
}

