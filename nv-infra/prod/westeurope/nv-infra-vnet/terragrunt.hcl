terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.46"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name   = "nv-gen-infra-rg"
  create_resource_group = true
  name                  = "nv-gen-infra-vnet"
  address_space         = ["10.46.0.0/19"]
  dns_servers           = ["10.40.250.4", "10.40.250.5"]

  subnets = [
    {
      name             = "nv-gen-infra-vm-subnet"
      address_prefixes = ["10.46.1.128/25"]
    },
  ]

  peerings = [
    {
      name                    = "nv-gen-infra_to_nv-hub",
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit   = false
      allow_forwarded_traffic = true
      use_remote_gateways     = true
    },
  ]
}
