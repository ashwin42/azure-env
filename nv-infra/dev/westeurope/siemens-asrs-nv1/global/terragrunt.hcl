terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.14"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix              = "asrs-nv1-dev"
  address_space             = [ "10.44.5.176/28", "10.44.5.192/28" ]
  dns_servers               = [ "10.40.250.5", "10.40.250.4" ]
  subnets                   = [
    {
      name = "asrs-nv1-dev-subnet-10.44.5.176-28"
      address_prefixes  = [ "10.44.5.176/28" ]
      service_endpoints = [ "Microsoft.Sql" ]
      enforce_private_link = true
    },
    {
      name = "asrs-nv1-dev-subnet-10.44.5.192-28"
      address_prefixes  = [ "10.44.5.192/28" ]
      service_endpoints = []
      enforce_private_link = false
    },
  ]
  peerings = [
    {
      name                  = "asrs_nv1-dev2nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}
