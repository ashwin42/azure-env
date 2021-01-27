terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.4"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix      = "nv-e3"
  address_space     = ["10.44.5.128/29"]
  subnets           = ["10.44.5.128/29"]
  dns_servers       = ["10.40.250.5", "10.40.250.4"]
  service_endpoints = ["Microsoft.Storage"]
  peerings = [
    {
      name                = "nv-e32nv-hub",
      vnet_id             = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
    },
    {
      name                = "nv_e3_to_nv_infra",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_infra/providers/Microsoft.Network/virtualNetworks/nv_infra"
      use_remote_gateways = false
    }
  ]
}
