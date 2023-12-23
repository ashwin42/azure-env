terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name   = "nv-gen-infra-rg"
  create_resource_group = true
  name                  = "nv-gen-infra-vnet"
  address_space         = ["10.46.0.0/19"]
  dns_servers           = ["10.40.250.4", "10.40.250.5"]

  route_tables = [
    {
      name = "nv-gen-infra-vnet-default-rt"
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
        {
          address_prefix         = "10.46.96.0/19" #Azure West Europe DWA
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
        {
          address_prefix         = "10.64.0.0/19" #Azure Sweden Central Prod General Vnet
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        }
      ]
    }
  ]

  subnets = [
    {
      name               = "nv-gen-infra-vm-subnet"
      netbox_subnet_name = "nv-gen-infra general vm subnet"
      address_prefixes   = ["10.46.1.128/25"]
    },
  ]

  peerings = [
    {
      name                    = "nv-gen-infra_to_nv-hub",
      vnet_id                 = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit   = false
      allow_forwarded_traffic = true
      use_remote_gateways     = true
    },
  ]
}
