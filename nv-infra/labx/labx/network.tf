resource "azurerm_public_ip" "labx" {
  name                = "labx-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                      = "${var.name}-nic"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.nv_labx_nsg.id

  ip_configuration {
    name                          = "${var.name}-nic_config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    private_ip_address            = var.ipaddress
    public_ip_address_id          = azurerm_public_ip.labx.id
  }
}

resource "azurerm_network_security_group" "nv_labx_nsg" {
  name                = "nv_labx_nsg"
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
    name                       = "Allow_Inbound_pontus"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "83.233.110.244"
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

}
