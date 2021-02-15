terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vpn_gateway?ref=v0.2.7"
  #source = "../../../../../tf-mod-azure/vpn_gateway"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../core-network"
}

inputs = {
  resource_group_name = "core_network"
  vpn_gateways = [
    {
      name           = "nw-hub-vpn-gw-core"
      active_active  = "false"
      public_ip_name = "public-vpn-gw-core"
      ip_config_name = "vpn-gw-config-core"
      subnet_id      = dependency.vnet.outputs.subnet.GatewaySubnet.id
      enable_bgp     = true
    },
    #    {
    #      name                = "test"
    #      active_active       = "true"
    #      subnet_id           = dependency.vnet.outputs.subnet.GatewaySubnet.id
    #      bgp_asn             = "65511"
    #      bgp_peering_address = "10.41.254.254"
    #      bgp_peer_weight     = "3"
    #    }
  ]
}
