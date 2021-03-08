resource "azurerm_public_ip" "polarion-ip" {
  name                = "polarion-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# nv_polarion vnet
resource "azurerm_virtual_network" "nv_polarion_vnet" {
  resource_group_name = azurerm_resource_group.nv_polarion.name
  location            = var.location
  name                = "nv_polarion_vnet"
  address_space       = ["10.44.4.0/27"]
  tags                = merge(var.default_tags, {})
}

# nv_polarion subnets
resource "azurerm_subnet" "nv_polarion_subnet" {
  resource_group_name  = azurerm_resource_group.nv_polarion.name
  virtual_network_name = azurerm_virtual_network.nv_polarion_vnet.name
  name                 = "nv_polarion_subnet_2"
  address_prefix       = "10.44.4.0/28"
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.nv_polarion_vnet.name
  address_prefix       = "10.44.4.16/28"
}

resource "azurerm_bastion_host" "polarion_bastion" {
  name                = "polarion_bastion"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.polarion-ip.id
  }
}
