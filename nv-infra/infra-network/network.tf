# infra vnet
resource "azurerm_virtual_network" "nv_infra" {
  resource_group_name = azurerm_resource_group.nv_infra.name
  location            = var.location
  name                = "nv_infra"
  address_space       = ["10.80.0.0/16"]
  # Once AADDS is in place, this should be enabled/changed
  dns_servers = ["10.40.250.4", "10.40.250.5"]
  tags = merge(var.default_tags, {})
}

resource "azurerm_subnet" "vdi_subnet" {
  resource_group_name  = azurerm_resource_group.nv_infra.name
  virtual_network_name = azurerm_virtual_network.nv_infra.name
  name                 = "vdi_subnet"
  address_prefix       = "10.80.0.0/27"
}

resource "azurerm_virtual_network_peering" "nv_infra_to_nv-hub" {
  name                         = "nv_infra_to_nv-hub"
  resource_group_name          = azurerm_resource_group.nv_infra.name
  virtual_network_name         = azurerm_virtual_network.nv_infra.name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}
