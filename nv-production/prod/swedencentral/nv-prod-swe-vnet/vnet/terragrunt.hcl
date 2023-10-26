terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = include.root.locals.all_vars.setup_prefix
  address_space            = ["10.64.0.0/19"]
  route_tables = [
    {
      name = "nv-production-swc-default-rt"
      routes = [
        {
          address_prefix         = "10.40.0.0/16" #Azure WestEurope Hub
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.0.0/16" #Azure WestEurope General Vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        }
      ]
    }
  ]
  peerings = [
    {
      name                    = "nv-prod-swe_to_nv-hub"
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/hub_rg/providers/Microsoft.Network/virtualNetworks/hub_vnet"
      allow_gateway_transit   = false
      allow_forwarded_traffic = true
      use_remote_gateways     = true
    },
  ]
}

