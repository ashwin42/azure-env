terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//virtual_network_gateway/netbox?ref=v0.9.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//virtual_network_gateway/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../core-network"
}

inputs = {
  resource_group_name = "core_network"
  public_ips = [
    {
      name              = "public-vpn-gw-core"
      allocation_method = "Dynamic"
      availability_zone = "No-Zone"
    },
  ]
  gateways = [
    {
      name          = "nw-hub-vpn-gw-core"
      sku           = "VpnGw3"
      type          = "Vpn"
      active_active = "false"
      ip_configuration = [
        {
          name                          = "vpn-gw-config-core"
          private_ip_address_allocation = "Dynamic"
          public_ip_address_name        = "public-vpn-gw-core"
          subnet_id                     = dependency.vnet.outputs.subnets.GatewaySubnet.id
        }
      ]
      enable_bgp = true
      bgp_settings = {
        asn         = "65515"
        peer_weight = "0"
        peering_addresses = [
          {
            apipa_addresses       = ["169.254.22.9"]
            ip_configuration_name = "vpn-gw-config-core"
          }
        ]
      }
    },
  ]
}
