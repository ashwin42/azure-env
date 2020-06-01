resource "azurerm_resource_group" "nv_infra" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, {})
}

resource "azurerm_management_lock" "nv_infra_lock" {
  name       = "nv_infra_lock"
  scope      = azurerm_resource_group.nv_infra.id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's a core component"
}
