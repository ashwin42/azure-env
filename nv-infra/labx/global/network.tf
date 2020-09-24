# labx vnet
resource "azurerm_virtual_network" "nv_labx_vnet" {
  resource_group_name = azurerm_resource_group.nv_labx.name
  location            = var.location
  name                = "nv_labx_vnet"
  address_space       = ["10.44.2.0/24"]
  dns_servers         = ["10.40.250.4", "10.40.250.5"]
  tags                = merge(var.default_tags, {})
}

# labx subnets
resource "azurerm_subnet" "labx_subnet" {
  resource_group_name  = azurerm_resource_group.nv_labx.name
  virtual_network_name = azurerm_virtual_network.nv_labx_vnet.name
  name                 = "labx_subnet"
  address_prefix       = "10.44.2.0/26"
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_virtual_network_peering" "nv_labx_vnet_to_nv-hub" {
  name                         = "nv_labx_vnet_to_nv-hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.nv_labx_vnet.name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}
