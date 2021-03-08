resource "azurerm_public_ip" "nv-preactor-ip" {
  name                = "nv-preactor-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "preactor_bastion" {
  name                = "preactor_bastion"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.nv-preactor-ip.id
  }
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.nv_preactor_vnet.name
  address_prefix       = "10.44.5.8/29"
}

resource "azurerm_virtual_network" "nv_preactor_vnet" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "nv_preactor_vnet"
  address_space       = ["10.44.5.0/28"]
}

# nv_preactor subnets
resource "azurerm_subnet" "nv_preactor_subnet" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.nv_preactor_vnet.name
  name                 = "nv_preactor_subnet"
  address_prefix       = "10.44.5.0/29"
}

resource "azurerm_network_interface" "main" {
  name                      = "${var.name}-nic"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.nv_preactor_nsg.id

  ip_configuration {
    name                          = "${var.name}-nic_config"
    subnet_id                     = azurerm_subnet.nv_preactor_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = var.ipaddress
  }
}

