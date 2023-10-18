terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.8.0"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  address_space  = ["10.44.2.0/24"]
  dns_servers    = ["10.40.250.5", "10.40.250.4"]
  vnet_name      = "nv_labx_vnet"
  lock_resources = false

  subnets = [
    {
      name                                      = "labx_subnet"
      address_prefixes                          = ["10.44.2.0/26"]
      service_endpoints                         = ["Microsoft.Sql", "Microsoft.Storage"]
      private_endpoint_network_policies_enabled = false
    },
  ]

  peerings = [
    {
      name                    = "nv_labx_vnet_to_nv-hub",
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_forwarded_traffic = true
      use_remote_gateways     = true
    },
    {
      name                    = "nv_labx_to_nv_infra",
      vnet_id                 = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_infra/providers/Microsoft.Network/virtualNetworks/nv_infra"
      allow_forwarded_traffic = true
      use_remote_gateways     = false
    }
  ]
}
