terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rg" {
  config_path = "../resource_group"
}

inputs = {
  setup_prefix             = ""
  vnet_name                = "nv-prod-swe-vnet"
  vnet_resource_group_name = "nv-prod-swe-vnet-rg"
  resource_group_name = dependency.rg.outputs.resource_group_name
  subnets = [
    {
      name                        = "nv-lims-img-subnet"
      address_prefixes            = ["10.64.16.0/27"]
      network_security_group_name = "nv-lims-img-nsg"
      service_endpoints = [
        "Microsoft.Storage",
      ]
    },
  ]
  network_security_groups = [
    {
      name               = "nv-lims-img-nsg"
      move_default_rules = true
      rules = [
        {
          name                   = "Labs_MFA_VPN"
          priority               = "200"
          direction              = "Inbound"
          source_address_prefix  = include.root.locals.all_vars.vpn_subnet_labs
          source_port_range      = "*"
          destination_port_range = "*"
          protocol               = "Tcp"
          access                 = "Allow"
          description            = "Allow connections from Labs MFA VPN clients"
        },
        {
          name                   = "Ett_MFA_VPN"
          priority               = "201"
          direction              = "Inbound"
          source_address_prefix  = include.root.locals.all_vars.vpn_subnet_ett
          source_port_range      = "*"
          destination_port_range = "*"
          protocol               = "Tcp"
          access                 = "Allow"
          description            = "Allow connections from Ett MFA VPN clients"
        },
        {
          name                   = "Dwa_MFA_VPN"
          priority               = "202"
          direction              = "Inbound"
          source_address_prefix  = include.root.locals.all_vars.vpn_subnet_dwa
          source_port_range      = "*"
          destination_port_range = "*"
          protocol               = "Tcp"
          access                 = "Allow"
          description            = "Allow connections from Dwa MFA VPN clients"
        },
      ]
    }
  ]
}

