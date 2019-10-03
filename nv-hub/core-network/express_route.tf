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
