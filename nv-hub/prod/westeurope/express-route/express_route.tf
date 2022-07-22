resource "azurerm_express_route_circuit" "main" {
  name                  = "LabsExpressRoute"
  resource_group_name   = var.resource_group_name
  location              = var.location
  service_provider_name = "Telia Carrier"
  peering_location      = "Amsterdam"
  bandwidth_in_mbps     = 200

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }

  tags = merge(var.default_tags, var.repo_tag, var.module_tag, var.env_tag, var.tags, {})
}

output "labs_express_route_skey" {
  value     = azurerm_express_route_circuit.main.service_key
  sensitive = true
}

resource "azurerm_express_route_circuit_authorization" "er-to-er-gw" {
  name                       = "er-to-er-gw"
  express_route_circuit_name = azurerm_express_route_circuit.main.name
  resource_group_name        = var.resource_group_name
}

resource "azurerm_virtual_network_gateway_connection" "er-gw-to-er" {
  name                       = "er-gw-to-er"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  type                       = "ExpressRoute"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.nv-hub-er-gw.id
  authorization_key          = azurerm_express_route_circuit_authorization.er-to-er-gw.authorization_key
  express_route_circuit_id   = azurerm_express_route_circuit.main.id
  tags                       = merge(var.default_tags, var.repo_tag, var.module_tag, var.env_tag, var.tags, {})

  lifecycle {
    ignore_changes = [authorization_key]
  }
}

resource "azurerm_express_route_circuit_peering" "this" {
  peering_type                  = "AzurePrivatePeering"
  express_route_circuit_name    = azurerm_express_route_circuit.main.name
  resource_group_name           = var.resource_group_name
  peer_asn                      = 1299
  primary_peer_address_prefix   = "10.225.225.132/30"
  secondary_peer_address_prefix = "10.225.225.136/30"
  vlan_id                       = 102

  microsoft_peering_config {
    advertised_public_prefixes = []
    customer_asn               = 0
    routing_registry_name      = "NONE"
  }
}
