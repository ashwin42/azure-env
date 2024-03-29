#
# Main TeamCenter server network setup
#

resource "azurerm_network_security_group" "teamcenter_security_group" {
  name                = "${var.application_name}_security_group"
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "license_server"
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

resource "azurerm_network_interface" "teamcenter_network_interface" {
  count                     = var.teamcenter_server_count
  name                      = "${var.application_name}${count.index}-network_interface"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.teamcenter_security_group.id

  ip_configuration {
    name                          = "${var.application_name}${count.index}-network_interface_ip_config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    private_ip_address            = cidrhost(var.subnet_prefix, count.index + 5)
  }
}

#
# GPU render server network setup
#

resource "azurerm_network_security_group" "tc_gpu_security_group" {
  count               = var.enable_render_server ? 1 : 0
  name                = "${var.application_name}_tc_gpu_security_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_network_interface" "tc_gpu_network_interface" {
  count                     = var.enable_render_server ? 1 : 0
  name                      = "${azurerm_network_security_group.tc_gpu_security_group[0].name}_network_interface"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.tc_gpu_security_group[0].id

  ip_configuration {
    name                          = "${azurerm_network_security_group.tc_gpu_security_group[0].name}_network_interface_ip_config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    private_ip_address            = cidrhost(var.subnet_prefix, 20)
  }
}

#
# Licensing server network setup
#

resource "azurerm_network_security_group" "tc_license_security_group" {
  name                = "${var.application_name}_tc_license_security_group"
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "license_server"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "28000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "tc_license_network_interface" {
  name                      = "${azurerm_network_security_group.tc_license_security_group.name}_network_interface"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.tc_license_security_group.id

  ip_configuration {
    name                          = "${azurerm_network_security_group.tc_license_security_group.name}_network_interface_ip_config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    private_ip_address            = cidrhost(var.subnet_prefix, 100)
  }
}

