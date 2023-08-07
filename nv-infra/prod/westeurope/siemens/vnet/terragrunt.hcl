terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vnet_name     = "nv_siemens_vnet"
  address_space = ["10.44.1.0/24"]
  dns_servers   = ["10.40.250.4", "10.40.250.5"]

  subnets = [
    {
      name             = "siemens_fs20_fire"
      address_prefixes = ["10.44.1.0/27"]
    },
    {
      name             = "siemens_cameras"
      address_prefixes = ["10.44.1.32/27"]
    },
    {
      name             = "siemens_spc_controllers"
      address_prefixes = ["10.44.1.64/27"]
    },
    {
      name             = "siemens_sipass_controllers"
      address_prefixes = ["10.44.1.96/27"]
    },
    {
      name                                      = "siemens_system_subnet"
      address_prefixes                          = ["10.44.1.128/26"]
      service_endpoints                         = ["Microsoft.Sql"]
      private_endpoint_network_policies_enabled = false
    },
    {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.44.1.192/27"]
    },
  ]

  peerings = [
    {
      name                         = "nv_siemens_to_nv-hub",
      vnet_id                      = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit        = false
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
      use_remote_gateways          = true
    },
    {
      name                         = "nv_siemens_to_nv-arx",
      vnet_id                      = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/arx-rg/providers/Microsoft.Network/virtualNetworks/arx-vnet"
      allow_gateway_transit        = false
      allow_virtual_network_access = true
      allow_forwarded_traffic      = false
      use_remote_gateways          = false
    },
  ]

  iam_assignments = {
    "Reader" = {
      users = ["karel.silha@northvolt.com"]
    },
  },
}


