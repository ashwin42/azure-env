resource "azurerm_express_route_circuit" "main" {
  name                  = "LabsExpressRoute"
  resource_group_name   = azurerm_resource_group.core_network.name
  location              = var.location
  service_provider_name = "Telia Carrier"
  peering_location      = "Amsterdam"
  bandwidth_in_mbps     = 200

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }

  tags = merge(var.default_tags, {})
}

output "labs_express_route_skey" {
  value = azurerm_express_route_circuit.main.service_key
}

resource "azurerm_express_route_circuit_authorization" "er-to-er-gw" {
  name                       = "er-to-er-gw"
  express_route_circuit_name = azurerm_express_route_circuit.main.name
  resource_group_name        = azurerm_resource_group.core_network.name
}

resource "azurerm_virtual_network_gateway_connection" "er-gw-to-er" {
  name                = "er-gw-to-er"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  type                       = "ExpressRoute"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.nv-hub-er-gw.id
  authorization_key          = azurerm_express_route_circuit_authorization.er-to-er-gw.authorization_key
  express_route_circuit_id   = azurerm_express_route_circuit.main.id
}
