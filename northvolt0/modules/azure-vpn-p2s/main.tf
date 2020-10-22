resource "azurerm_public_ip" "virtual_network_gateway_public_ip" {
  name                = "${var.resource_group_name}_p2s_vnet_gw_pub_ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = "${var.virtual_network_name}_p2s_gateway"
  resource_group_name = var.resource_group_name
  location            = var.location

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "${var.virtual_network_name}_p2s_gateway_config"
    public_ip_address_id          = azurerm_public_ip.virtual_network_gateway_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway_subnet_id
  }
  # vpn_client_configuration {
  #   address_space = ["${var.client_address_space}"]
  # }
}

