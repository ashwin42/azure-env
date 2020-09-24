resource "azurerm_resource_group" "nv_labx" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, {})
}

resource "azurerm_management_lock" "nv_labx_lock" {
  name       = "nv_labx_lock"
  scope      = azurerm_resource_group.nv_labx.id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's a core component"
}

