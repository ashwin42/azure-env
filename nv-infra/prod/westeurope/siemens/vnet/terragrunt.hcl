terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name     = "nv_siemens_vnet"
  address_space = ["10.44.1.0/24"]
  dns_servers   = ["10.40.250.4", "10.40.250.5"]

  subnets = [
    {
      name             = "siemens_fs20_fire"
      address_prefixes = ["10.44.1.0/27"]
      route_table_name = "nv_siemens_vnet_default_rt"
    },
    {
      name             = "siemens_cameras"
      address_prefixes = ["10.44.1.32/27"]
      route_table_name = "nv_siemens_vnet_default_rt"
    },
    {
      name             = "siemens_spc_controllers"
      address_prefixes = ["10.44.1.64/27"]
      route_table_name = "nv_siemens_vnet_default_rt"
    },
    {
      name             = "siemens_sipass_controllers"
      address_prefixes = ["10.44.1.96/27"]
      route_table_name = "nv_siemens_vnet_default_rt"
    },
    {
      name                                      = "siemens_system_subnet"
      address_prefixes                          = ["10.44.1.128/26"]
      service_endpoints                         = ["Microsoft.Sql"]
      private_endpoint_network_policies_enabled = false
      route_table_name                          = "nv_siemens_vnet_default_rt"
    },
    {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.44.1.192/27"]
    },
  ]

  route_tables = [
    {
      name = "nv_siemens_vnet_default_rt"
      routes = [
        {
          address_prefix         = "10.12.0.0/14" #AWS it-prod vpc
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.18.0.0/15" #AWS it-prod vpc
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.20.0.0/14" #AWS it-prod vpc
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.24.0.0/13" #AWS it-prod vpc
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.32.0.0/13" #AWS it-prod vpc
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
      ]
    }
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


