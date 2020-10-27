resource "azurerm_resource_group" "nv_labx2" {
  name     = "nv_labx2"
  location = var.location
  tags     = merge(var.default_tags, {})
}

#resource "azurerm_management_lock" "azurerm_resource_group" {
#  count      = var.lock_resources ? 1 : 0
#  name       = "${var.setup_prefix}-resource_group-ml"
#  scope      = azurerm_resource_group.this.id
#  lock_level = "CanNotDelete"
#  notes      = "Locked because it's a core component"
#}
#
