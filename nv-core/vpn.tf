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

# AWS Root VPC
resource "azurerm_local_network_gateway" "aws" {
  name                = "aws"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  gateway_address     = "13.53.151.188"
  address_space       = ["10.103.0.0/16"]
}

data "azurerm_key_vault_secret" "aws_psk" {
  name      = "vpn-aws-psk"
  vault_uri = "${data.azurerm_key_vault.nv-core.vault_uri}"
}

resource "azurerm_virtual_network_gateway_connection" "aws" {
  name                = "AWS_Root_vpn"
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

# AWS Automation VPC
resource "azurerm_local_network_gateway" "aws_automation" {
  name                = "aws_automation"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  gateway_address     = "13.53.147.1"
  address_space       = ["10.104.0.0/16"]
}

data "azurerm_key_vault_secret" "aws_automation_psk" {
  name      = "vpn-aws-automation-psk"
  vault_uri = "${data.azurerm_key_vault.nv-core.vault_uri}"
}

resource "azurerm_virtual_network_gateway_connection" "aws_automation" {
  name                = "AWS_Automation_VPN"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  type                       = "IPsec"
  virtual_network_gateway_id = "${module.azure_vpn.virtual_network_gateway_id}"
  local_network_gateway_id   = "${azurerm_local_network_gateway.aws_automation.id}"

  shared_key = "${data.azurerm_key_vault_secret.aws_automation_psk.value}"
}

resource "azurerm_route_table" "aws_automation" {
  name                = "aws_automation_routingtable"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_route" "aws_automation1" {
  name                = "aws_automation_root_subnets_route"
  resource_group_name = "${var.resource_group_name}"
  route_table_name    = "${azurerm_route_table.aws_automation.name}"
  address_prefix      = "10.104.0.0/16"
  next_hop_type       = "VirtualNetworkGateway"
}

# Fully redundant dynamically routed VPN
# resource "azurerm_public_ip" "main_vngw_primary" {
#   name                    = "main_vnet_gw_primary"
#   resource_group_name     = "${var.resource_group_name}"
#   location                = "${var.location}"
#   allocation_method       = "Dynamic"
#   idle_timeout_in_minutes = 30
# }

# resource "azurerm_public_ip" "main_vngw_secondary" {
#   name                    = "main_vnet_gw_secondary"
#   resource_group_name     = "${var.resource_group_name}"
#   location                = "${var.location}"
#   allocation_method       = "Dynamic"
#   idle_timeout_in_minutes = 30
# }

# resource "azurerm_virtual_network_gateway" "main" {
#   name                = "main_vnet_gw"
#   resource_group_name = "${var.resource_group_name}"
#   location            = "${var.location}"

#   type     = "Vpn"
#   vpn_type = "RouteBased"

#   active_active = true
#   enable_bgp    = true
#   sku           = "VpnGw1"

#   ip_configuration {
#     name                 = "main_vnet_gw_primary"
#     public_ip_address_id = "${azurerm_public_ip.main_vngw_primary.id}"
#     subnet_id            = "${azurerm_subnet.gateway_subnet.id}"
#   }

#   ip_configuration {
#     name                 = "main_vnet_gw_secondary"
#     public_ip_address_id = "${azurerm_public_ip.main_vngw_secondary.id}"
#     subnet_id            = "${azurerm_subnet.gateway_subnet.id}"
#   }
# }
