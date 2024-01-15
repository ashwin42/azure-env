terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = "nv-aviatrix-migration-vnet"
}

inputs = {
  resource_group_name   = "nv-gen-infra-rg"
  create_resource_group = false
  name                  = local.name
  address_space         = ["10.42.1.0/24"]
  dns_servers           = ["10.40.250.4", "10.40.250.5"]

  subnets = [
    {
      name             = "nv-aviatrix-migration-subnet"
      address_prefixes = ["10.42.1.0/26"]
    },
  ]

  peerings = [
    {
      name                    = "${local.name}_to_nv-hub",
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit   = false
      allow_forwarded_traffic = true
      use_remote_gateways     = true
    },
  ]
}
