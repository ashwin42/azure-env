resource "azurerm_network_interface" "main" {
  name                = "${var.name}-nic"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  ip_configuration {
    name                          = "${var.name}-nic_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.ipaddress}"
  }
}