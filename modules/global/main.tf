resource "azurerm_resource_group" "resource_group" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}

resource "azurerm_local_network_gateway" "northvolt_gamla_brogatan_26_local_network_gateway" {
    name                = "northvolt_gamla_brogatan_26"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    location            = "${var.location}"
    gateway_address     = "31.208.18.58"
    address_space       = ["192.168.118.0/24", "192.168.119.0/24"]
}