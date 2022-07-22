terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.4.0"
  #source = "../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../core-network"
}

locals {
  name = "hub-router"
}

inputs = {
  name = local.name
  resource_group_name = dependency.vnet.outputs.resource_group.name
  vm_size             = "Standard_B2s"
  managed_disk_type   = "Standard_LRS"
  backup_vm           = false
  localadmin_name     = "nvadmin"
  localadmin_key_name = "hub-router-nvadmin"
  storage_image_reference = {
    offer     = "0001-com-ubuntu-minimal-focal-daily",
    publisher = "Canonical",
    sku       = "minimal-20_04-daily-lts",
  }
  #encrypt_disks = true
  network_interfaces = [
    {
      name                 = "${local.name}-nic"
      enable_ip_forwarding = true
      ip_configuration = [
        {
          private_ip_address            = "10.40.253.5"
          subnet_id                     = dependency.vnet.outputs.subnet.hub-dmz.id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
          #public_ip_address_name        = "${local.name}-public-ip"
        },
      ]
    },
  ],
  #  public_ips = [
  #    {
  #      name = "${local.name}-public-ip"
  #    },
  #  ]
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

