terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}//tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../vnet-hub"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = "hub-router"
}

inputs = {
  name                                   = local.name
  vm_name                                = local.name
  netbox_vm_name                         = "hub-router-swc"
  netbox_create_role                     = true
  resource_group_name                    = "hub_rg"
  vm_size                                = "Standard_B2s"
  managed_disk_type                      = "Standard_LRS"
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  backup_vm                              = true
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "hub-router-nvadmin"
  storage_image_reference = {
    offer     = include.root.locals.all_vars.ubuntu_offer_minimal_20,
    publisher = include.root.locals.all_vars.ubuntu_publisher,
    sku       = include.root.locals.all_vars.ubuntu_sku_minimal_20,
  }
  network_interfaces = [
    {
      name                 = "${local.name}-nic"
      enable_ip_forwarding = true
      ip_configuration = [
        {
          private_ip_address            = "10.48.0.70"
          subnet_id                     = dependency.vnet.outputs.subnets["hub-dmz"].id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
          public_ip_address_name        = "${local.name}-public-ip"
        },
      ]
    },
  ],

  custom_rules = [
    # SSH from we hub router, To remove when routing is completed to/from on prem
    {
      name                       = "WestEurope_Hub_Router_SSH"
      priority                   = "202"
      direction                  = "Inbound"
      source_address_prefix      = "10.40.253.5/32"
      destination_address_prefix = "0.0.0.0/0"
      protocol                   = "Tcp"
      destination_port_range     = "22"
      access                     = "Allow"
      description                = "Allow connections from westeurope Hub router"
    },
    {
      name                       = "Temp"
      priority                   = "201"
      direction                  = "Inbound"
      source_address_prefix      = "94.254.76.224/32"
      destination_address_prefix = "0.0.0.0/0"
      protocol                   = "*"
      destination_port_range     = "0-65535"
      access                     = "Allow"
      description                = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                       = "Deny_SSH"
      priority                   = "210"
      direction                  = "Inbound"
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "10.48.0.70"
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

