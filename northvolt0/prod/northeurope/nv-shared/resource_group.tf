resource "azurerm_resource_group" "nv-shared" {
  name     = var.resource_group_name
  location = var.location
}

