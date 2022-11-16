terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//virtual_network_gateway?ref=v0.7.13"
  #source = "../../../../../tf-mod-azure/virtual_network_gateway"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../core-network"
}

inputs = {
  gateways = [
    {
      name                = "nw-hub-vpn-gw-core"
      resource_group_name = "core_network"
      active_active       = "false"
      public_ips = [
        {
          name              = "public-vpn-gw-core"
          allocation_method = "Dynamic"
          availability_zone = "No-Zone"
        },
      ]
      ip_configuration = [
        {
          name                          = "vpn-gw-config-core"
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = "public-vpn-gw-core"
          subnet_id                     = dependency.vnet.outputs.subnet.GatewaySubnet.id
        }
      ]
      enable_bgp = true
      bgp_settings = [
        {
          asn         = "65515"
          peer_weight = "0"
          peering_addresses = [
            {
              apipa_addresses       = ["169.254.22.9"]
              ip_configuration_name = "vpn-gw-config-core"
            }
          ]
        }
      ]
    },
  ]
}

