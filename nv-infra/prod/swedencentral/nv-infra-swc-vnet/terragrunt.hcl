terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name   = "nv-gen-infra-swc-rg"
  create_resource_group = true
  name                  = "nv-gen-infra-swc-vnet"
  netbox_description    = "nv-gen-infra-swc vnet"
  address_space         = ["10.64.32.0/19"]

  route_tables = [
    {
      name = "nv-gen-infra-swc-default-rt"
      routes = [
        {
          address_prefix         = "10.40.0.0/16" #Azure WestEurope Hub
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        },
        {
          address_prefix         = "10.46.0.0/16" #Azure WestEurope General Vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.48.0.70"
        }
      ]
    }
  ]

  subnets = [
    {
      name               = "nv-gen-infra-swc-subnet"
      netbox_subnet_name = "nv-gen-infra-swc general subnet"
      address_prefixes   = ["10.64.32.0/25"]
    },
    {
      name               = "nv-gen-infra-swc-aks-subnet"
      netbox_subnet_name = "nv-gen-infra-swc AKS subnet"
      route_table_name   = "nv-gen-infra-swc-default-rt"
      address_prefixes   = ["10.64.33.0/26"]
    },
    {
      name               = "nv-gen-infra-swc-aks-ingress-subnet"
      netbox_subnet_name = "nv-gen-infra-swc AKS ingress subnet"
      route_table_name   = "nv-gen-infra-swc-default-rt"
      address_prefixes   = ["10.64.33.64/27"]
    },
  ]

  peerings = [
    {
      name                    = "nv-gen-infra-swe_to_nv-hub"
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/hub_rg/providers/Microsoft.Network/virtualNetworks/hub_vnet"
      allow_gateway_transit   = false
      allow_forwarded_traffic = true
      use_remote_gateways     = true
    },
  ]
}

