# 800xa vnet
resource "azurerm_virtual_network" "abb_800xa" {
  resource_group_name = azurerm_resource_group.abb_800xa.name
  location            = var.location
  name                = "800xa"
  address_space       = ["10.60.0.0/16"]
  # Once AADDS is in place, this should be enabled/changed
  #dns_servers         = ["10.101.250.4", "10.101.250.5"]
  tags                = merge(var.default_tags, {})
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
  name                 = "800xa-1"
  address_prefix       = "10.60.60.0/24"
}