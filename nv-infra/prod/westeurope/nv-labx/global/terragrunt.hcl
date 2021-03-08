terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.14"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix        = "${basename(dirname(get_terragrunt_dir()))}"
  address_space       = ["10.44.2.0/24"]
  dns_servers         = ["10.40.250.5", "10.40.250.4"]
  resource_group_name = "nv_labx"
  recovery_vault_name = "labx-rv"
  vnet_name           = "nv_labx_vnet"
  vnet_peering_name   = "nv_labx_vnet_to_nv-hub"
  lock_resources      = "false"
  subnets = [
    {
      name                 = "labx_subnet"
      address_prefixes     = ["10.44.2.0/26"]
      service_endpoints    = ["Microsoft.Sql"]
      enforce_private_link = true
    },
  ]
  peerings = [
    {
      name                  = "nv_labx_vnet_to_nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}
