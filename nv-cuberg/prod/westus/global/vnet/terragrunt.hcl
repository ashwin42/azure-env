terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = "cuberg-vnet"
  address_space            = ["10.46.44.0/23"]
  subnets = [
    {
      name             = "cuberg-subnet"
      address_prefixes = ["10.46.44.0/25"]
    },
  ]
  peerings = [
    {
      name                  = "cuberg_to_nv-hub"
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}

