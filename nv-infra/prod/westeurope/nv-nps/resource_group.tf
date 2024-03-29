resource "azurerm_resource_group" "nv_nps" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, {})
}

resource "azurerm_network_security_group" "nv_nps_nsg" {
  name                = "nv_nps_nsg"
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "Allow_Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "62.20.55.58"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Factory"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "213.50.54.192/28"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Labs-Telia"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "62.20.23.0/28"
    destination_address_prefix = "*"
  }

}
