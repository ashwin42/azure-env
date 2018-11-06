resource "azurerm_subnet" "gateway_subnet" {
  name                 = "VpnGatewaySubnet"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
  address_prefix       = "${var.gateway_subnet_address_prefix}"
}

resource "azurerm_public_ip" "virtual_network_gateway_public_ip" {
  name                         = "${var.stage}_virtual_network_gateway_public_ip"
  resource_group_name          = "${var.resource_group_name}"
  location                     = "${var.location}"
  public_ip_address_allocation = "dynamic"
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = "${var.virtual_network_name}_gateway"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  type     = "Vpn"
  vpn_type = "PolicyBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "${var.virtual_network_name}_gateway_config"
    public_ip_address_id          = "${azurerm_public_ip.virtual_network_gateway_public_ip.id}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${azurerm_subnet.gateway_subnet.id}"
  }
}

resource "azurerm_virtual_network_gateway_connection" "site_to_site_gateway_connection" {
  name                = "${azurerm_virtual_network_gateway.virtual_network_gateway.name}_site_to_site_vpn"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  type                       = "IPsec"
  virtual_network_gateway_id = "${azurerm_virtual_network_gateway.virtual_network_gateway.id}"
  local_network_gateway_id   = "${var.local_network_gateway_id}"

  shared_key = "${var.gateway_connection_psk}"
}
