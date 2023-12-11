terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = include.root.locals.all_vars.setup_prefix
  netbox_vnet_name         = "nv-pnl-we-vnet"
  address_space            = ["10.46.40.0/22"]
  subnets = [
    {
      name               = "subnet1"
      netbox_subnet_name = "nv-pnl subnet 1"
      address_prefixes   = ["10.46.40.0/24"]
      route_table_name   = "nv-pnl-we-default-rt"
    },
  ]
  route_tables = [
    {
      name = "nv-pnl-we-default-rt"
      routes = [
        {
          address_prefix         = "10.40.0.0/16" #Azure WestEurope Hub
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.48.0.0/22" #Azure Sweden Central Hub
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.12.0.0/14" #AWS
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
      ]
    }
  ]
  peerings = [
    {
      name                    = "nv-pnl_to_nv-hub"
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit   = false
      allow_forwarded_traffic = true
      use_remote_gateways     = true
    },
  ]
}

