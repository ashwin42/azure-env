terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = null
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"

  subnets = [
    {
      name                        = "nv-labs-qc-subnet-10.46.2.32_28"
      netbox_subnet_name          = "nv-labs-qc"
      address_prefixes            = ["10.46.2.32/28"]
      network_security_group_name = "nv-labs-qc-subnet-nsg"
      service_endpoints = [
        "Microsoft.Sql",
        "Microsoft.Storage",
      ]
    },
  ]

  network_security_groups = [
    {
      name               = "nv-labs-qc-subnet-nsg"
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
          name                   = "Labs_QC"
          priority               = "202"
          direction              = "Inbound"
          source_address_prefix  = "10.192.1.0/24"
          source_port_range      = "*"
          destination_port_range = "*"
          protocol               = "Tcp"
          access                 = "Allow"
          description            = "Allow connections from Ett MFA VPN clients"
        },
      ]
      network_watcher_flow_log = include.root.inputs.network_watcher_flow_log
    }
  ]
}

