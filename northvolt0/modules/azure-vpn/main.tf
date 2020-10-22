resource "azurerm_public_ip" "virtual_network_gateway_public_ip" {
  name                = "${var.resource_group_name}_vnet_gw_pub_ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = "${var.virtual_network_name}_gateway"
  resource_group_name = var.resource_group_name
  location            = var.location

  type     = "Vpn"
  vpn_type = var.vpn_type

  active_active = false
  enable_bgp    = false
  sku           = var.sku

  ip_configuration {
    name                          = "${var.virtual_network_name}_gateway_config"
    public_ip_address_id          = azurerm_public_ip.virtual_network_gateway_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway_subnet_id
  }
}

resource "azurerm_virtual_network_gateway_connection" "site_to_site_gateway_connection" {
  name                = "${azurerm_virtual_network_gateway.virtual_network_gateway.name}_site_to_site_vpn"
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.virtual_network_gateway.id
  local_network_gateway_id   = var.local_network_gateway_id

  shared_key = var.gateway_connection_psk
}

resource "azurerm_route_table" "nv_hq" {
  name                = "nv_hqroutingtable"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "nv_hq" {
  name                = "nv_hq_subnets_route"
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.nv_hq.name
  address_prefix      = "10.10.8.0/23"
  next_hop_type       = "VirtualNetworkGateway"
}

