terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.12"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix  = "nv-cell-assembly-ws"
  address_space = ["10.44.5.96/27"]
  dns_servers   = ["10.40.250.5", "10.40.250.4"]
  subnets = [
    {
      name             = "nv-cell-assembly-ws-subnet-10.44.5.96"
      address_prefixes = ["10.44.5.96/27"]
    },
  ]
  peerings = [
    {
      name                  = "nv-cell-assembly-ws2nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}
