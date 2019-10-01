# Gamla Brogatan
resource "azurerm_local_network_gateway" "gamla_brogatan_26" {
  name                = "nv-gamla_brogatan_26"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  gateway_address     = "31.208.18.58"
  address_space       = ["192.168.118.0/23", "192.168.113.0/24"]
}

data "azurerm_key_vault" "nv-core" {
  name                = "nv-core"
  resource_group_name = "nv-core"
}

data "azurerm_key_vault_secret" "gateway_connection_psk" {
  name         = "vpn-hq-psk"
  key_vault_id = "${data.azurerm_key_vault.nv-core.id}"
}

module "azure_vpn" {
  source                   = "../modules/azure-vpn"
  resource_group_name      = "${var.resource_group_name}"
  vpn_type                 = "RouteBased"
  sku                      = "VpnGw1"
  virtual_network_name     = "${var.virtual_network_name}"
  gateway_subnet_id        = "${azurerm_subnet.gateway_subnet.id}"
  local_network_gateway_id = "${azurerm_local_network_gateway.gamla_brogatan_26.id}"
  gateway_connection_psk   = "${data.azurerm_key_vault_secret.gateway_connection_psk.value}"
  location                 = "${var.location}"
}
