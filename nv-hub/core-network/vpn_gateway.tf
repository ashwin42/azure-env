# core_vnet_vpn
resource "azurerm_virtual_network" "core_vnet_vpn" {
  resource_group_name = azurerm_resource_group.core_network.name
  location            = var.location
  name                = "core_vnet_vpn"
  address_space       = ["10.42.1.0/24"]
  dns_servers = ["10.40.250.4", "10.40.250.5"]
  tags        = merge(var.default_tags, {})
}


resource "azurerm_subnet" "GatewaySubnetVPN" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.core_network.name
  virtual_network_name = azurerm_virtual_network.core_vnet_vpn.name
  address_prefix       = "10.42.1.0/24"
}

resource "azurerm_public_ip" "public-vpn-gw" {
  name                = "public-vpn-gw"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "nv-hub-vpn-gw" {
  name                = "nw-hub-vpn-gw"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  type = "Vpn"

  sku = "VpnGw3"

  ip_configuration {
    name                 = "vpn-gw-config"
    public_ip_address_id = azurerm_public_ip.public-vpn-gw.id
    subnet_id            = azurerm_subnet.GatewaySubnetVPN.id
  }
}