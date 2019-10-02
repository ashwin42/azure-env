resource "azurerm_express_route_circuit" "main" {
  name                  = "LabsExpressRoute"
  resource_group_name   = var.resource_group_name
  location              = var.location
  service_provider_name = "Telia"
  peering_location      = "Amsterdam"
  bandwidth_in_mbps     = 200

  sku {
    tier   = "Standard"
    family = "UnlimitedData"
  }

  tags     = merge(var.default_tags, {})
}