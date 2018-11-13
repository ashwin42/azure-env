#
# Main TeamCenter server network setup
#

resource "azurerm_network_security_group" "teamcenter_security_group" {
  name                = "${var.application_name}_security_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  # Allow RDP from HQ
  security_rule {
    name                       = "RDP_from_HQ"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes    = ["192.168.118.0/24", "192.168.119.0/24"]
    destination_address_prefix = "${cidrhost(var.subnet_prefix, 5)}"
  }
}

resource "azurerm_network_interface" "teamcenter_network_interface" {
  name                      = "${azurerm_network_security_group.teamcenter_security_group.name}_network_interface"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.teamcenter_security_group.id}"

  ip_configuration {
    name                          = "${azurerm_network_security_group.teamcenter_security_group.name}_network_interface_ip_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(var.subnet_prefix, 5)}"
  }
}

#
# GPU render server network setup
#

resource "azurerm_network_security_group" "tc_gpu_security_group" {
  count               = "${var.enable_render_server ? 1 : 0}"
  name                = "${var.application_name}_tc_gpu_security_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
}

resource "azurerm_network_interface" "tc_gpu_network_interface" {
  count                     = "${var.enable_render_server ? 1 : 0}"
  name                      = "${azurerm_network_security_group.tc_gpu_security_group.name}_network_interface"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.tc_gpu_security_group.id}"

  ip_configuration {
    name                          = "${azurerm_network_security_group.tc_gpu_security_group.name}_network_interface_ip_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(var.subnet_prefix, 8)}"
  }
}

#
# Licensing server network setup
#

resource "azurerm_network_security_group" "tc_license_security_group" {
  name                = "${var.application_name}_tc_license_security_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
}

resource "azurerm_network_interface" "tc_license_network_interface" {
  name                      = "${azurerm_network_security_group.tc_license_security_group.name}_network_interface"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.tc_license_security_group.id}"

  ip_configuration {
    name                          = "${azurerm_network_security_group.tc_license_security_group.name}_network_interface_ip_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(var.subnet_prefix, 10)}"
  }
}
