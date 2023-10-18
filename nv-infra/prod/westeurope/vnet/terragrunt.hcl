terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.7.44"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/global"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix          = "nv_infra"
  address_space         = ["10.80.0.0/16"]
  dns_servers           = ["10.40.250.4", "10.40.250.5"]
  create_recovery_vault = false
  resource_group_name   = "nv_infra"
  vnet_name             = "nv_infra"
  lock_resources        = false
  subnets = [
    {
      name                 = "vdi_subnet"
      address_prefixes     = ["10.80.0.0/27"]
      service_endpoints    = ["Microsoft.Storage"]
      enforce_private_link = true
    },
  ]
  peerings = [
    {
      name                  = "nv_infra_to_nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
    {
      name                  = "nv_infra_to_nv_e3",
      vnet_id               = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-e3-rg/providers/Microsoft.Network/virtualNetworks/nv-e3-vnet",
      use_remote_gateways   = false
      allow_gateway_transit = false
    },
    {
      name                  = "nv_infra_to_nv_labx",
      vnet_id               = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_labx/providers/Microsoft.Network/virtualNetworks/nv_labx_vnet",
      use_remote_gateways   = false
      allow_gateway_transit = false
    }
  ]
}

