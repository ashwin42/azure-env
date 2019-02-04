resource "azurerm_resource_group" "nv-lab" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}
