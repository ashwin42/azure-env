resource "azurerm_network_security_group" "security_group" {
    name                = "${var.application_name}_security_group"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
}

resource "azurerm_network_security_rule" "security_rule_ssh" {
  name                        = "${azurerm_network_security_group.security_group.name}_security_rule_ssh"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.security_group.name}"

  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_network_interface" "network_interface" {
    name                      = "${azurerm_network_security_group.security_group.name}_network_interface"
    resource_group_name       = "${var.resource_group_name}"
    location                  = "${var.location}"
    network_security_group_id = "${azurerm_network_security_group.security_group.id}"

    ip_configuration {
        name                          = "${azurerm_network_security_group.security_group.name}_network_interface_ip_configuration"
        subnet_id                     = "${azurerm_subnet.app_subnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}