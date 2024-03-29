data "azurerm_virtual_network" "nv_network_mon_vnet" {
  name                = "nv_network_mon_vnet"
  resource_group_name = "nv_network_mon"
}

data "azurerm_subnet" "nv_nps_subnet" {
  name                 = "nv_nps_subnet"
  virtual_network_name = "nv_network_mon_vnet"
  resource_group_name  = "nv_network_mon"
}

resource "azurerm_network_interface" "main" {
  name                      = "${var.name}-nic"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.nv_nps_nsg2.id

  ip_configuration {
    name                          = "${var.name}-nic_config"
    subnet_id                     = data.azurerm_subnet.nv_nps_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = var.ipaddress
  }
}

