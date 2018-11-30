resource "azurerm_network_security_group" "tia_security_group" {
  name                = "${var.application_name}_security_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
    
    security_rule {
    name                       = "Allow_Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_interface" "tia_network_interface" {
  count                     = "${var.tia_server_count}"
  name                      = "${var.application_name}${count.index}-network_interface"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.tia_security_group.id}"

  ip_configuration {
    name                          = "${var.application_name}${count.index}-network_interface_ip_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(var.subnet_prefix, count.index + 200)}"
  }
}
