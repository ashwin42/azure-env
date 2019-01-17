resource "azurerm_local_network_gateway" "gamla_brogatan_26" {
  name                = "nv-gamla_brogatan_26"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  gateway_address     = "31.208.18.58"
  address_space       = ["192.168.118.0/24", "192.168.119.0/24", "192.168.113.0/24"]
}

data "azurerm_key_vault" "nv-core" {
  name                = "nv-core"
  resource_group_name = "${var.resource_group_name}"
}

data "azurerm_key_vault_secret" "gateway_connection_psk" {
  name      = "vpn-hq-psk"
  vault_uri = "${data.azurerm_key_vault.nv-core.vault_uri}"
}

module "azure_vpn" {
  source                   = "../modules/azure-vpn"
  resource_group_name      = "${var.resource_group_name}"
  vpn_type                 = "RouteBased"
  virtual_network_name     = "${azurerm_virtual_network.core_vnet.name}"
  gateway_subnet           = "${var.gateway_subnet}"
  local_network_gateway_id = "${azurerm_local_network_gateway.gamla_brogatan_26.id}"
  gateway_connection_psk   = "${data.azurerm_key_vault_secret.gateway_connection_psk.value}"
  location                 = "${var.location}"
}
