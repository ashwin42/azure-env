# 800xa vnet
resource "azurerm_virtual_network" "abb_800xa" {
  resource_group_name = azurerm_resource_group.abb_800xa.name
  location            = var.location
  name                = "800xa"
  address_space       = ["10.60.0.0/16"]
  tags = merge(var.default_tags, {})
}

# 800xa subnets
resource "azurerm_subnet" "abb_800xa_1" {
  resource_group_name  = azurerm_resource_group.abb_800xa.name
  virtual_network_name = azurerm_virtual_network.abb_800xa.name
  name                 = "800xa-1"
  address_prefix       = "10.60.50.0/24"
}

# 800xa subnets
resource "azurerm_subnet" "abb_800xa_2" {
  resource_group_name  = azurerm_resource_group.abb_800xa.name
  virtual_network_name = azurerm_virtual_network.abb_800xa.name
  name                 = "800xa-2"
  address_prefix       = "10.60.60.0/24"
}

# 800xa subnets
resource "azurerm_subnet" "abb_800xa_3" {
  resource_group_name  = azurerm_resource_group.abb_800xa.name
  virtual_network_name = azurerm_virtual_network.abb_800xa.name
  name                 = "800xa-3"
  address_prefix       = "10.60.51.0/24"
}

resource "azurerm_virtual_network_peering" "abb800xa_to_nv-hub" {
  name                         = "nv-production_to_nv-hub"
  resource_group_name          = azurerm_resource_group.abb_800xa.name
  virtual_network_name         = azurerm_virtual_network.abb_800xa.name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}
