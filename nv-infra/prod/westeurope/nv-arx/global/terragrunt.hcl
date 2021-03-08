terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.12"
  #source = "../../../../../../tf-mod-azure/global/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix        = "arx"
  address_space       = ["10.44.5.16/28"]
  dns_servers         = ["10.40.250.5", "10.40.250.4"]
  recovery_vault_name = "ARX-RV"
  subnets = [
    {
      name             = "arx-server-subnet"
      address_prefixes = ["10.44.5.16/28"]
    },
  ]
  peerings = [
    {
      name                  = "nv-arx_to_nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      use_remote_gateways   = true
      allow_gateway_transit = false
    },
  ]
}
