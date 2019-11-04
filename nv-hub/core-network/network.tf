# core_vnet
resource "azurerm_virtual_network" "core_vnet" {
  resource_group_name = azurerm_resource_group.core_network.name
  location            = var.location
  name                = "core_vnet"
  address_space       = ["10.40.0.0/16"]
  # Once AADDS is in place, this should be enabled/changed
  #dns_servers         = ["10.101.250.4", "10.101.250.5"]
  tags = merge(var.default_tags, {})
}

resource "azurerm_virtual_network_peering" "nv-hub_to_800xa" {
  name                         = "nv-hub_to_nv-production"
  resource_group_name          = azurerm_resource_group.core_network.name
  virtual_network_name         = azurerm_virtual_network.core_vnet.name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.core_network.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefix       = "10.40.254.0/24"
}

resource "azurerm_public_ip" "public-er-gw" {
  name                = "public-er-gw"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "nv-hub-er-gw" {
  name                = "nw-hub-er-gw"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  type = "ExpressRoute"

  sku = "Standard"

  ip_configuration {
    name                 = "er-gw-config"
    public_ip_address_id = azurerm_public_ip.public-er-gw.id
    subnet_id            = azurerm_subnet.GatewaySubnet.id
  }
}