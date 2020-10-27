#resource "azurerm_resource_group" "nv_nps2" {
#  name     = var.resource_group_name
#  location = var.location
#  tags     = merge(var.default_tags, {})
#}
#
#resource "azurerm_management_lock" "resource-group-level" {
#  name       = "resource-group-level"
#  scope      = azurerm_resource_group.nv_nps2.id
#  lock_level = "CanNotDelete"
#  notes      = "This Resource Group is Read-Only"
#}

resource "azurerm_network_security_group" "nv_nps_nsg2" {
  name                = "nv_nps_nsg2"
  resource_group_name = var.resource_group_name
  location            = var.location
}

