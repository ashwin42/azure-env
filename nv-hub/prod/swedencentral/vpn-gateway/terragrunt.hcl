terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//virtual_network_gateway?ref=v0.4.0"
  #source = "../../../../../tf-mod-azure/virtual_network_gateway"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../vnet-hub"
}

locals {
  vpn_gw_name = "nv-hub-swc-vpn-gw"
}

inputs = {
  gateways = [
    {
      name                = local.vpn_gw_name
      resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name
      generation          = "Generation2"
      sku                 = "VpnGw3AZ"
      active_active       = "true"
      public_ips = [
        {
          name              = "${local.vpn_gw_name}-ip-1"
          allocation_method = "Static"
          sku               = "Standard"
          zones             = ["1", "2", "3"]
        },
        {
          name              = "${local.vpn_gw_name}-ip-2"
          allocation_method = "Static"
          sku               = "Standard"
          zones             = ["1", "2", "3"]
        },
      ]
      ip_configuration = [
        {
          name                          = "${local.vpn_gw_name}-ip-conf-1"
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = "${local.vpn_gw_name}-ip-1"
          subnet_id                     = dependency.vnet.outputs.subnet.GatewaySubnet.id
        },
        {
          name                          = "${local.vpn_gw_name}-ip-conf-2"
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = "${local.vpn_gw_name}-ip-2"
          subnet_id                     = dependency.vnet.outputs.subnet.GatewaySubnet.id
        },
      ]
      private_ip_address_enabled = true
      enable_bgp                 = true
      bgp_settings = [
        {
          asn         = "65514"
          peer_weight = "0"
          peering_addresses = [
            {
              apipa_addresses       = ["169.254.22.29"]
              ip_configuration_name = "${local.vpn_gw_name}-ip-conf-1"
            },
            {
              apipa_addresses       = ["169.254.22.30"]
              ip_configuration_name = "${local.vpn_gw_name}-ip-conf-2"
            },
          ]
        }
      ]
    },
  ]
}

