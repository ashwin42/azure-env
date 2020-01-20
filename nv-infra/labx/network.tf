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
    subnet_id                     = azurerm_subnet.labx_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = var.ipaddress
    public_ip_address_id          = azurerm_public_ip.labx.id
  }
}

# labx vnet
resource "azurerm_virtual_network" "nv_labx_vnet" {
  resource_group_name = azurerm_resource_group.nv_labx.name
  location            = var.location
  name                = "nv_labx_vnet"
  address_space       = ["10.44.2.0/24"]
  tags                = merge(var.default_tags, {})
}

# labx subnets
resource "azurerm_subnet" "labx_subnet" {
  resource_group_name  = azurerm_resource_group.nv_labx.name
  virtual_network_name = azurerm_virtual_network.nv_labx_vnet.name
  name                 = "labx_subnet"
  address_prefix       = "10.44.2.0/26"
}
