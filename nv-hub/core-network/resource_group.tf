resource "azurerm_resource_group" "core_network" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, {})
}
