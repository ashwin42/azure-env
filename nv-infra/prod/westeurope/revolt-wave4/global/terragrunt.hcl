terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/global"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix      = "revolt-wave4"
  address_space     = ["10.44.5.144/28"]
  dns_servers       = ["10.40.250.5", "10.40.250.4"]
  service_endpoints = ["Microsoft.Storage"]
  subnets = [
    {
      name                 = "revolt-wave4-subnet-10.44.5.144-28"
      address_prefixes     = ["10.44.5.144/28"]
      service_endpoints    = ["Microsoft.Storage"]
      enforce_private_link = true
      route_table_name     = "revolt-wave4-subnet_default-rt"
    },
  ]
  route_tables = [
    {
      name = "revolt-wave4-subnet_default-rt"
      routes = [
        {
          address_prefix         = "10.0.0.0/8"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
      ]
    }
  ]
  peerings = [
    {
      name                  = "revolt-wave42nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}
