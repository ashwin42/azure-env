terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.18"
  #source = "../../../../../tf-mod-azure/global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix          = "nv-gen-infra"
  address_space         = ["10.46.0.0/19"]
  dns_servers           = ["10.40.250.4", "10.40.250.5"]
  create_recovery_vault = false
  lock_resources        = false
  subnets = [
    {
      name             = "nv-gen-infra-vm-subnet"
      address_prefixes = ["10.46.1.128/25"]
    },
  ]
  peerings = [
    {
      name                  = "nv-gen-infra_to_nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}
