resource "azurerm_network_security_group" "teamcenter_security_group" {
  name                = "${var.application_name}_security_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
}

resource "azurerm_network_interface" "teamcenter_network_interface" {
  name                      = "${azurerm_network_security_group.teamcenter_security_group.name}_network_interface"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.teamcenter_security_group.id}"

  ip_configuration {
    name                          = "${azurerm_network_security_group.teamcenter_security_group.name}_network_interface_ip_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_network_security_group" "tc_gpu_security_group" {
  name                = "${var.application_name}_tc_gpu_security_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
}

resource "azurerm_network_interface" "tc_gpu_network_interface" {
  name                      = "${azurerm_network_security_group.tc_gpu_security_group.name}_network_interface"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.tc_gpu_security_group.id}"

  ip_configuration {
    name                          = "${azurerm_network_security_group.tc_gpu_security_group.name}_network_interface_ip_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
  }
}
