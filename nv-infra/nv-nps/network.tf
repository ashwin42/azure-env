data "azurerm_virtual_network" "nv_network_mon_vnet" {
  name                = "nv_network_mon_vnet"
  resource_group_name = "nv_network_mon"
}

data "azurerm_subnet" "nv_nps_subnet" {
  name                 = "nv_nps_subnet"
  virtual_network_name = "nv_network_mon_vnet"
  resource_group_name  = "nv_network_mon"
}

resource "azurerm_public_ip" "nv-nps-ip" {
  name                = "nps-pip-e2d5647a48a84f2bb2320adb4a777b67"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  name                      = "nps-nic-8ca5eefe90644c88bfb13248c0eb6012"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.nv_nps_nsg.id

  ip_configuration {
    name                          = "9fc138ea62014d42a9437c63e3beff13"
    subnet_id                     = data.azurerm_subnet.nv_nps_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = var.ipaddress
    public_ip_address_id          = azurerm_public_ip.nv-nps-ip.id
  }
}

output "public_ip_address" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_public_ip.nv-nps-ip.ip_address
}

