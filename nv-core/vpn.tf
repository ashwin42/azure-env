data "azurerm_key_vault" "nv-core" {
  name                = "nv-core"
  resource_group_name = "${var.resource_group_name}"
}

# Gamla Brogatan
resource "azurerm_local_network_gateway" "gamla_brogatan_26" {
  name                = "nv-gamla_brogatan_26"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  gateway_address     = "31.208.18.58"
  address_space       = ["192.168.118.0/23", "192.168.113.0/24"]
}

data "azurerm_key_vault_secret" "gateway_connection_psk" {
  name      = "vpn-hq-psk"
  vault_uri = "${data.azurerm_key_vault.nv-core.vault_uri}"
}

module "azure_vpn" {
  source                   = "../modules/azure-vpn"
  resource_group_name      = "${var.resource_group_name}"
  vpn_type                 = "RouteBased"
  sku                      = "VpnGw1"
  virtual_network_name     = "${azurerm_virtual_network.core_vnet.name}"
  gateway_subnet_id        = "${azurerm_subnet.gateway_subnet.id}"
  local_network_gateway_id = "${azurerm_local_network_gateway.gamla_brogatan_26.id}"
  gateway_connection_psk   = "${data.azurerm_key_vault_secret.gateway_connection_psk.value}"
  location                 = "${var.location}"
}

# AWS
resource "azurerm_local_network_gateway" "aws" {
  name                = "aws"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  gateway_address     = "13.53.158.28"
  address_space       = ["10.103.0.0/16", "10.104.0.0/16"]
}

data "azurerm_key_vault_secret" "aws_psk" {
  name      = "vpn-aws-psk"
  vault_uri = "${data.azurerm_key_vault.nv-core.vault_uri}"
}

resource "azurerm_virtual_network_gateway_connection" "aws" {
  name                = "AWS_site_to_site_vpn"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  type                       = "IPsec"
  virtual_network_gateway_id = "${module.azure_vpn.virtual_network_gateway_id}"
  local_network_gateway_id   = "${azurerm_local_network_gateway.aws.id}"

  shared_key = "${data.azurerm_key_vault_secret.aws_psk.value}"
}

resource "azurerm_route_table" "aws" {
  name                = "aws_routingtable"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_route" "aws1" {
  name                = "aws_root_subnets_route"
  resource_group_name = "${var.resource_group_name}"
  route_table_name    = "${azurerm_route_table.aws.name}"
  address_prefix      = "10.103.0.0/16"
  next_hop_type       = "VirtualNetworkGateway"
}

resource "azurerm_route" "aws2" {
  name                = "aws_automation_subnets_route"
  resource_group_name = "${var.resource_group_name}"
  route_table_name    = "${azurerm_route_table.aws.name}"
  address_prefix      = "10.104.0.0/16"
  next_hop_type       = "VirtualNetworkGateway"
}