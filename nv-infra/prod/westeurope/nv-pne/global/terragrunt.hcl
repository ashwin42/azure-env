terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.9.4"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix        = "nv-pne"
  resource_group_name = "nv-pne-rg"
  address_space       = ["10.44.5.32/27"]
  dns_servers         = ["10.40.250.5", "10.40.250.4"]
  subnets = [
    {
      name              = "nv-pne-subnet-10.44.5.32"
      address_prefixes  = ["10.44.5.32/27"]
      service_endpoints = ["Microsoft.Storage"]
      route_table_name  = "nv_pne_vnet_default_rt"
    },
  ]
  peerings = [
    {
      name                  = "nv-pne2nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
  route_tables = [
    {
      name = "nv_pne_vnet_default_rt"
      routes = [
        {
          address_prefix         = "10.0.0.0/8"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
      ]
    }
  ]
}
