terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.6.9"
  #source = "../../../../../tf-mod-azure/vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = include.root.locals.all_vars.setup_prefix
  address_space            = ["10.46.40.0/22"]
  subnets = [
    {
      name             = "subnet1"
      address_prefixes = ["10.46.40.0/24"]
    },
  ]
  peerings = [
    {
      name                = "nv-pnl_to_nv-hub"
      vnet_id             = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}

