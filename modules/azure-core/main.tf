resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.stage}_virtual_network"
  resource_group_name = "${var.resource_group_name}"
  address_space       = "${var.virtual_network_address_space}"
  location            = "${var.location}"
}

resource "azurerm_subnet" "subnet_internal" {
  name                 = "test-internal"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
  address_prefix       = "${var.subnet_internal_prefix}"
}

resource "azurerm_local_network_gateway" "gamla_brogatan_26_local_gateway" {
  name                = "northvolt_gamla_brogatan_26"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  gateway_address     = "31.208.18.58"
  address_space       = ["192.168.118.0/24", "192.168.119.0/24"]
}
