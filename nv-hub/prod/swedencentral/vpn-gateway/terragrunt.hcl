terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//virtual_network_gateway/netbox?ref=v0.9.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//virtual_network_gateway/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../vnet-hub"
}

locals {
  vpn_gw_name = "nv-hub-swc-vpn-gw"
}

inputs = {
  resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name
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
  gateways = [
    {
      name          = local.vpn_gw_name
      generation    = "Generation2"
      sku           = "VpnGw3AZ"
      type          = "Vpn"
      active_active = "true"
      ip_configuration = [
        {
          name                          = "${local.vpn_gw_name}-ip-conf-1"
          private_ip_address_allocation = "Dynamic"
          public_ip_address_name        = "${local.vpn_gw_name}-ip-1"
          subnet_id                     = dependency.vnet.outputs.subnet.GatewaySubnet.id
        },
        {
          name                          = "${local.vpn_gw_name}-ip-conf-2"
          private_ip_address_allocation = "Dynamic"
          public_ip_address_name        = "${local.vpn_gw_name}-ip-2"
          subnet_id                     = dependency.vnet.outputs.subnet.GatewaySubnet.id
        },
      ]
      private_ip_address_enabled = true
      enable_bgp                 = true
      bgp_settings = {
        asn         = "65514"
        peer_weight = "0"
        peering_addresses = [
          {
            apipa_addresses       = ["169.254.22.26", "169.254.22.22"]
            ip_configuration_name = "${local.vpn_gw_name}-ip-conf-1"
          },
          {
            apipa_addresses       = ["169.254.22.30", "169.254.22.34"]
            ip_configuration_name = "${local.vpn_gw_name}-ip-conf-2"
          },
        ]
      }
    },
  ]
}

