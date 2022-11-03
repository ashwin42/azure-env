terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.8"
  #source = "../../../../../tf-mod-azure/vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = include.root.locals.all_vars.setup_prefix
  address_space            = ["10.64.0.0/19"]
  peerings = [
    {
      name                  = "nv-prod-swe_to_nv-hub"
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/hub_rg/providers/Microsoft.Network/virtualNetworks/hub_vnet"
      allow_gateway_transit = false
    },
  ]
}

