terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.4.0"
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
  subnets = [
    {
      name              = "GatewaySubnet"
      address_prefixes  = ["10.48.0.0/26"]
      service_endpoints = []
    },
    {
      name              = "hub-dmz"
      address_prefixes  = ["10.48.0.64/27"]
      service_endpoints = []
    },
    {
      name              = "nv-domain-services"
      address_prefixes  = ["10.48.0.96/28"]
      service_endpoints = []
    },
  ]
  peerings = [
    {
      name                = "hub-swc2hub-we",
      vnet_id             = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      use_remote_gateways = false
    },
  ]
}
