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

  sku = "VpnGw3"

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

data "azurerm_key_vault_secret" "azure_to_labs_s2s" {
  name         = "azure-to-labs-s2s"
  key_vault_id = data.azurerm_key_vault.nv_hub_core.id
}

resource "azurerm_local_network_gateway" "azure_to_labs_s2s" {
  name                = "azure-to-labs-s2s"
  resource_group_name = azurerm_resource_group.core_network.name
  location            = var.location
  gateway_address     = "213.50.54.194"
  address_space       = ["10.244.255.0/30"]

  bgp_settings {
    asn                 = "65307"
    bgp_peering_address = "10.244.255.2"
  }
}

resource "azurerm_virtual_network_gateway_connection" "azure_to_labs_s2s" {
  name                = "azure-to-labs-s2s"
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.nv_hub_vpn_gw_core.id
  local_network_gateway_id   = azurerm_local_network_gateway.azure_to_labs_s2s.id
  shared_key                 = data.azurerm_key_vault_secret.azure_to_labs_s2s.value
  enable_bgp                 = true

  ipsec_policy {
    dh_group         = "DHGroup14"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "AES256"
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS24"
    sa_lifetime      = "27000"
  }

}

data "azurerm_key_vault_secret" "azure_to_lilje_office_s2s" {
  name         = "azure-to-lilje-office-s2s-psk"
  key_vault_id = data.azurerm_key_vault.nv_hub_core.id
}

resource "azurerm_local_network_gateway" "azure_to_lilje_office_s2s" {
  name                = "azure-to-lilje-office-s2s"
  resource_group_name = azurerm_resource_group.core_network.name
  location            = var.location
  gateway_address     = "98.128.134.222"
  address_space       = ["10.245.255.0/30"]

  bgp_settings {
    asn                 = "65407"
    bgp_peering_address = "10.245.255.2"
  }
}

resource "azurerm_virtual_network_gateway_connection" "azure_to_lilje_office_s2s" {
  name                = "azure-to-lilje-office-s2s"
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.nv_hub_vpn_gw_core.id
  local_network_gateway_id   = azurerm_local_network_gateway.azure_to_lilje_office_s2s.id
  shared_key                 = data.azurerm_key_vault_secret.azure_to_lilje_office_s2s.value
  enable_bgp                 = true

  ipsec_policy {
    dh_group         = "DHGroup14"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "AES256"
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS24"
    sa_lifetime      = "27000"
  }

}
