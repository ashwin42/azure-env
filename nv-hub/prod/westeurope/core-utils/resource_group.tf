resource "azurerm_resource_group" "core_utils" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, {})
}
