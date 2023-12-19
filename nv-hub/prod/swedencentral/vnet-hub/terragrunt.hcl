terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = "hub_rg"
  vnet_name                = "hub_vnet"
  netbox_vnet_name         = "Public Clouds -- Azure - swedencentral HUB VNET"
  address_space            = ["10.48.0.0/23"]
  create_resource_group    = true
  dns_servers              = []
  route_tables = [
    {
      name = "nv-hub-swc-default-rt"
      routes = [
        {
          address_prefix         = "10.40.0.0/16" #Azure WestEurope Hub
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.96.0/19" #Azure WestEurope hub - DWA
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.40.0/22" #Azure WestEurope hub - PNL
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.0.0/19" #Azure WestEurope nv-gen-infra-vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.44.1.0/24" #Azure WestEurope - Siemens Physical Security
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.44.5.16/28" #Azure WestEurope - ARX vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.0.128/28" #Azure WestEurope - LV-Incore vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.1.48/28" #Azure WestEurope - APIS-IQ vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.1.0/29" #Azure WestEurope - Autodesk-Vault vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.44.5.96/27" #Azure WestEurope - Cell-Assembly WS vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.44.5.144/28" #Azure WestEurope - Revolt-Wave4 vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.44.5.32/27" #Azure WestEurope - NV-PNE (Gen_Infra)
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
      ]
    },
    {
      name = "nv-hub-swc-hub-router-rt"
      routes = [
        {
          address_prefix         = "10.40.0.0/16" #Azure WestEurope Hub
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.96.0/19" #Azure WestEurope hub - DWA
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.40.0/22" #Azure WestEurope hub - PNL
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.0.0/19" #Azure WestEurope nv-gen-infra-vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.44.1.0/24" #Azure WestEurope - Siemens Physical Security
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.44.5.16/28" #Azure WestEurope - ARX vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.0.128/28" #Azure WestEurope - LV-Incore vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.1.48/28" #Azure WestEurope - APIS-IQ vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.46.1.0/29" #Azure WestEurope - Autodesk-Vault vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.44.5.96/27" #Azure WestEurope - Cell-Assembly WS vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.44.5.144/28" #Azure WestEurope - Revolt-Wave4 vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.44.5.32/27" #Azure WestEurope - NV-PNE (Gen_Infra)
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
      ]
    }
  ]
  subnets = [
    {
      name              = "GatewaySubnet"
      address_prefixes  = ["10.48.0.0/26"]
      route_table_name  = "nv-hub-swc-default-rt"
      service_endpoints = []
    },
    {
      name              = "hub-dmz"
      address_prefixes  = ["10.48.0.64/27"]
      service_endpoints = []
      route_table_name  = "nv-hub-swc-hub-router-rt"
    },
    {
      name              = "nv-domain-services"
      address_prefixes  = ["10.48.0.96/28"]
      service_endpoints = []
      route_table_name  = "nv-hub-swc-default-rt"
    },
    {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.48.0.128/26"]
    }
  ]
  peerings = [
    {
      name                    = "hub-swc2hub-we",
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      use_remote_gateways     = false
      allow_forwarded_traffic = true
      allow_gateway_transit   = true
    },
    {
      name                    = "hub-swc-to-nv-prod-swe",
      vnet_id                 = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/nv-prod-swe-vnet-rg/providers/Microsoft.Network/virtualNetworks/nv-prod-swe-vnet"
      use_remote_gateways     = false
      allow_forwarded_traffic = true
      allow_gateway_transit   = true
    },
    {
      name                    = "hub-swc-to-ett-revolt-prod-swc",
      vnet_id                 = "/subscriptions/f652c928-a8cb-4d8f-9175-bbe0a0128eb0/resourceGroups/ett-revolt-prod-general-rg/providers/Microsoft.Network/virtualNetworks/ett-revolt-prod-general"
      use_remote_gateways     = false
      allow_forwarded_traffic = true
      allow_gateway_transit   = true
    },
    {
      name                    = "hub-swc-to-nv-gen-infra-swe_to_nv-hub"
      vnet_id                 = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-gen-infra-swc-rg/providers/Microsoft.Network/virtualNetworks/nv-gen-infra-swc-vnet"
      use_remote_gateways     = false
      allow_forwarded_traffic = true
      allow_gateway_transit   = true
    },
    {
      name                    = "hub-swc-to-labs-prod-swe"
      vnet_id                 = "/subscriptions/82f99951-a219-463b-97ff-011a0d6e28a4/resourceGroups/labs-prod-general-rg/providers/Microsoft.Network/virtualNetworks/labs-prod-general"
      use_remote_gateways     = false
      allow_forwarded_traffic = true
      allow_gateway_transit   = true
    },
    {
      name                    = "hub-swc-to-ett-prod-swe"
      vnet_id                 = "/subscriptions/6eec4236-13f1-41e0-9779-d50ad6c64edd/resourceGroups/ett-prod-general-rg/providers/Microsoft.Network/virtualNetworks/ett-prod-general"
      use_remote_gateways     = false
      allow_forwarded_traffic = true
      allow_gateway_transit   = true
    },
  ]
}
