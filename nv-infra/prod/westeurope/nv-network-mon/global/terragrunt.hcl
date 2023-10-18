terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.15"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix        = "nv_network_mon"
  resource_group_name = "nv_network_mon"
  nsg0_name_alt       = "nv_network_mon_nsg"
  address_space       = ["10.44.3.0/24"]
  dns_servers         = ["10.40.250.4", "10.40.250.5"]
  recovery_vault_name = "nv-network-mon-recovery-vault"
  vnet_name           = "nv_network_mon_vnet"
  lock_resources      = true
  subnets = [
    {
      name             = "nv_network_mon_subnet"
      address_prefixes = ["10.44.3.0/27"]
    },
    {
      name             = "nv_nps_subnet"
      address_prefixes = ["10.44.3.32/27"]
    },
  ]
  peerings = [
    {
      name                  = "nv_network_mon_to_nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}
