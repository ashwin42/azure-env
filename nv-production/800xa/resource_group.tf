resource "azurerm_resource_group" "abb_800xa" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, {})
}
