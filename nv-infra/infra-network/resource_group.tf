resource "azurerm_resource_group" "nv_infra" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, {})
}
