# core_vnet
resource "azurerm_virtual_network" "core_vnet" {
  resource_group_name = azurerm_resource_group.core_network.name
  location            = var.location
  name                = "core_vnet"
  address_space       = ["10.40.0.0/16"]
  # Once AADDS is in place, this should be enabled/changed
  #dns_servers         = ["10.101.250.4", "10.101.250.5"]
  tags = merge(var.default_tags, {})
}

resource "azurerm_virtual_network_peering" "nv-hub_to_800xa" {
  name                      = "nv-hub_to_nv-production"
  resource_group_name       = azurerm_resource_group.core_network.name
  virtual_network_name      = azurerm_virtual_network.core_vnet.name
  remote_virtual_network_id = var.remote_virtual_network_id
}
