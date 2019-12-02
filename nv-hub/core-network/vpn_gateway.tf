# core_vnet_vpn
resource "azurerm_virtual_network" "core_vnet_vpn" {
  resource_group_name = azurerm_resource_group.core_network.name
  location            = var.location
  name                = "core_vnet_vpn"
  address_space       = ["10.42.1.0/24"]
  dns_servers         = ["10.40.250.4", "10.40.250.5"]
  tags                = merge(var.default_tags, {})
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

# core_vnet VPN
resource "azurerm_public_ip" "public_vpn_gw_core" {
  name                = "public-vpn-gw-core"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "nv_hub_vpn_gw_core" {
  name                = "nw-hub-vpn-gw-core"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  type = "Vpn"

  sku = "VpnGw1"

  ip_configuration {
    name                 = "vpn-gw-config-core"
    public_ip_address_id = azurerm_public_ip.public_vpn_gw_core.id
    subnet_id            = azurerm_subnet.GatewaySubnet.id
  }
}

# AWS Ireland Production Transit Gateway
resource "azurerm_local_network_gateway" "aws_ireland_prod_tgw" {
  name                = "aws-ireland-prod-tgw"
  resource_group_name = azurerm_resource_group.core_network.name
  location            = var.location
  gateway_address     = "52.19.7.38"
  address_space       = ["10.21.0.0/16"]
}

data "azurerm_key_vault_secret" "aws_ireland_prod_tgw_psk" {
  name         = "vpn-aws-ireland-prod-tgw-psk"
  key_vault_id = data.azurerm_key_vault.nv_hub_core.id
}

resource "azurerm_virtual_network_gateway_connection" "aws_ireland_prod_tgw" {
  name                = "aws_ireland_prod_tgw"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.nv_hub_vpn_gw_core.id
  local_network_gateway_id   = azurerm_local_network_gateway.aws_ireland_prod_tgw.id

  shared_key = data.azurerm_key_vault_secret.aws_ireland_prod_tgw_psk.value
}

resource "azurerm_route_table" "aws_ireland_prod_tgw" {
  name                = "aws_ireland_prod_tgw_routingtable"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name
}

resource "azurerm_route" "aws_ireland_prod_tgw" {
  name                = "aws_ireland_prod_tgw_subnets_route"
  resource_group_name = azurerm_resource_group.core_network.name
  route_table_name    = azurerm_route_table.aws_ireland_prod_tgw.name
  address_prefix      = "10.21.0.0/16"
  next_hop_type       = "VirtualNetworkGateway"
}
