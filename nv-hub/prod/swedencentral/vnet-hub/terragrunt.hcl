terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.6.12"
  #source = "../../../../../tf-mod-azure/vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = "hub_rg"
  setup_prefix             = "hub"
  vnet_name                = "hub_vnet"
  address_space            = ["10.48.0.0/23"]
  create_resource_group    = true
  dns_servers              = []
  route_tables = [
    {
      name = "nv-hub-swc-default-rt"
      routes = [
        {
          address_prefix         = "10.40.0.0/16" #Azure WestEurope Hub
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.96.0/19" #Azure WestEurope hub - DWA
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.40.0/22" #Azure WestEurope hub - PNL
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.0.0/19" #Azure WestEurope nv-gen-infra-vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.44.1.0/24" #Azure WestEurope - Siemens Physical Security
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
      ]
    },
    {
      name = "nv-hub-swc-hub-router-rt"
      routes = [
        {
          address_prefix         = "10.40.0.0/16" #Azure WestEurope Hub
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.96.0/19" #Azure WestEurope hub - DWA
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.40.0/22" #Azure WestEurope hub - PNL
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.0.0/19" #Azure WestEurope nv-gen-infra-vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.44.1.0/24" #Azure WestEurope - Siemens Physical Security
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
      ]
    }
  ]
  subnets = [
    {
      name              = "GatewaySubnet"
      address_prefixes  = ["10.48.0.0/26"]
      route_table_name  = "nv-hub-swc-default-rt"
      service_endpoints = []
    },
    {
      name              = "hub-dmz"
      address_prefixes  = ["10.48.0.64/27"]
      service_endpoints = []
      route_table_name  = "nv-hub-swc-hub-router-rt"
    },
    {
      name              = "nv-domain-services"
      address_prefixes  = ["10.48.0.96/28"]
      service_endpoints = []
      route_table_name  = "nv-hub-swc-default-rt"
    },
  ]
  peerings = [
    {
      name                = "hub-swc2hub-we",
      vnet_id             = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      use_remote_gateways = false
    },
    {
      name                = "hub-swc-to-nv-prod-swe",
      vnet_id             = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/nv-prod-swe-vnet-rg/providers/Microsoft.Network/virtualNetworks/nv-prod-swe-vnet"
      use_remote_gateways = false
    },
  ]
}
