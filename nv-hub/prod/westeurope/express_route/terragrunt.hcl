terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//express_route?ref=v0.7.39"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/express_route"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../core-network"
}

inputs = {
  resource_group_name = "core_network"

  express_route_circuits = [
    {
      name                  = "LabsExpressRoute"
      authorizations        = ["er-to-er-gw"]
      peering_location      = "Amsterdam"
      bandwidth_in_mbps     = 200
      service_provider_name = "Telia Carrier"

      sku = {
        tier   = "Standard"
        family = "MeteredData"
      }
    },
  ]

  express_route_circuit_peerings = [
    {
      azure_asn                     = 12076
      express_route_circuit_name    = "LabsExpressRoute"
      vlan_id                       = 102
      peering_type                  = "AzurePrivatePeering"
      primary_peer_address_prefix   = "10.225.225.132/30"
      secondary_peer_address_prefix = "10.225.225.136/30"
      microsoft_peering_config = {
        customer_asn = 0
      }
    },
  ]

  public_ips = [
    {
      name              = "public-er-gw"
      allocation_method = "Dynamic"
      availability_zone = "No-Zone"
    },
  ]

  virtual_network_gateways = [
    {
      name = "nw-hub-er-gw"
      sku  = "Standard"

      ip_configuration = [
        {
          name                   = "er-gw-config"
          public_ip_address_name = "public-er-gw"
          subnet_id              = dependency.vnet.outputs.subnets.GatewaySubnet.id
        }
      ]
    },
  ]

  virtual_network_gateway_connections = [
    {
      name                         = "er-gw-to-er"
      virtual_network_gateway_name = "nw-hub-er-gw"
      express_route_circuit_name   = "LabsExpressRoute"
      routing_weight               = 0
    },
  ]
}

