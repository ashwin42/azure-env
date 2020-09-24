data "azurerm_subnet" "labx_subnet" {
  name                 = "labx_subnet"
  virtual_network_name = "nv_labx_vnet"
  resource_group_name  = "nv_labx"
}

resource "azurerm_public_ip" "labx2" {
  name                = "labx-ip2"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                      = "${var.name}-nic"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.nv_labx2_nsg.id

  ip_configuration {
    name                          = "${var.name}-nic_config"
    subnet_id                     = data.azurerm_subnet.labx_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = var.ipaddress
    public_ip_address_id          = azurerm_public_ip.labx2.id
  }
}

