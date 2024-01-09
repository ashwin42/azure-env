terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.4"
  #source = "../../../../../tf-mod-azure/vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = include.root.locals.all_vars.setup_prefix
  address_space            = ["10.46.64.0/19"]
  dns_servers              = ["10.40.250.4", "10.40.250.5"]
  peerings = [
    {
      name                    = "nv-prod-weu_to_nv-hub"
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit   = false
      allow_forwarded_traffic = true
      use_remote_gateways     = true
    },
  ]
}
