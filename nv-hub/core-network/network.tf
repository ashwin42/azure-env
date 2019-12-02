# core_vnet
resource "azurerm_virtual_network" "core_vnet" {
  resource_group_name = azurerm_resource_group.core_network.name
  location            = var.location
  name                = "core_vnet"
  address_space       = ["10.40.0.0/16"]
  # Once AADDS is in place, this should be enabled/changed
  dns_servers = ["10.40.250.4", "10.40.250.5"]
  tags        = merge(var.default_tags, {})
}

output "core_vnet_id" {
  value = azurerm_virtual_network.core_vnet.id
}

resource "azurerm_virtual_network_peering" "nv-hub_to_800xa" {
  name                         = "nv-hub_to_nv-production"
  resource_group_name          = azurerm_resource_group.core_network.name
  virtual_network_name         = azurerm_virtual_network.core_vnet.name
  remote_virtual_network_id    = var.remote_800xa_vnet
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_virtual_network_peering" "nv-hub_to_csp" {
  name                         = "nv-hub_to_csp"
  resource_group_name          = azurerm_resource_group.core_network.name
  virtual_network_name         = azurerm_virtual_network.core_vnet.name
  remote_virtual_network_id    = var.remote_csp_vnet
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_virtual_network_peering" "nv-hub_to_wuxi" {
  name                         = "nv-hub_to_wuxi"
  resource_group_name          = azurerm_resource_group.core_network.name
  virtual_network_name         = azurerm_virtual_network.core_vnet.name
  remote_virtual_network_id    = var.remote_wuxi_vnet
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_virtual_network_peering" "nv-hub_to_infra" {
  name                         = "nv-hub_to_infra"
  resource_group_name          = azurerm_resource_group.core_network.name
  virtual_network_name         = azurerm_virtual_network.core_vnet.name
  remote_virtual_network_id    = var.remote_infra_vnet
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_virtual_network_peering" "nv-hub_to_siemens" {
  name                         = "nv-hub_to_siemens"
  resource_group_name          = azurerm_resource_group.core_network.name
  virtual_network_name         = azurerm_virtual_network.core_vnet.name
  remote_virtual_network_id    = var.remote_siemens_vnet
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.core_network.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefix       = "10.40.254.0/24"
}

resource "azurerm_public_ip" "public-er-gw" {
  name                = "public-er-gw"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "nv-hub-er-gw" {
  name                = "nw-hub-er-gw"
  location            = var.location
  resource_group_name = azurerm_resource_group.core_network.name

  type = "ExpressRoute"

  sku = "Standard"

  ip_configuration {
    name                 = "er-gw-config"
    public_ip_address_id = azurerm_public_ip.public-er-gw.id
    subnet_id            = azurerm_subnet.GatewaySubnet.id
  }
}

resource "azurerm_subnet" "core_vpn_mgmt_1" {
  name                 = "core-vpn-mgmt-1"
  resource_group_name  = azurerm_resource_group.core_network.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefix       = "10.40.5.0/24"
}

output "core_vpn_mgmt_1_id" {
  value = azurerm_subnet.core_vpn_mgmt_1.id
}

resource "azurerm_subnet" "core_vpn_client_1" {
  name                 = "core-vpn-client-1"
  resource_group_name  = azurerm_resource_group.core_network.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefix       = "10.40.6.0/24"
}

output "core_vpn_client_1_id" {
  value = azurerm_subnet.core_vpn_client_1.id
}

resource "azurerm_subnet" "core-utils-1" {
  name                 = "core-utils-1"
  resource_group_name  = azurerm_resource_group.core_network.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefix       = "10.40.10.0/24"
  service_endpoints    = ["Microsoft.Storage"]
}

output "core-utils-1-id" {
  value = azurerm_subnet.core-utils-1.id
}

resource "azurerm_subnet" "nv_domain_services" {
  name                 = "nv-domain-services"
  resource_group_name  = azurerm_resource_group.core_network.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefix       = "10.40.250.0/24"
  network_security_group_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_utils/providers/Microsoft.Network/networkSecurityGroups/aadds-nsg"
}

output "nv_domain_services-id" {
  value = azurerm_subnet.nv_domain_services.id
}
