resource "azurerm_network_security_group" "tia" {
  name                = "${local.fullname}-sg"
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

resource "azurerm_network_interface" "tia" {
  name                      = "${local.fullname}-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.tia.id}"

  ip_configuration {
    name                          = "${local.fullname}-nic_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.ipaddress}"
  }
}

resource "azurerm_dns_a_record" "tia" {
  name                = "${var.name}"
  zone_name           = "${var.dns_zone}"
  resource_group_name = "${var.resource_group_name}"
  ttl                 = 300
  records             = ["${var.ipaddress}"]
}
