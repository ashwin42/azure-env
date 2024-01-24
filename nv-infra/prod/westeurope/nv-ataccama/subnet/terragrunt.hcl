terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = ""
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  resource_group_name      = "nv-ataccama-rg"
  subnets = [
    {
      name                        = "nv-ataccama-subnet"
      address_prefixes            = ["10.46.2.16/28"]
      network_security_group_name = "nv-ataccama-subnet-nsg"
      route_table_name   = "nv-gen-infra-vnet-default-rt"
      service_endpoints = [
        "Microsoft.Sql",
        "Microsoft.Storage",
      ]
    },
  ]
  network_security_groups = [
    {
      name               = "nv-ataccama-subnet-nsg"
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
