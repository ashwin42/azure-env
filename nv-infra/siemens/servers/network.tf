# siemens vnet
resource "azurerm_virtual_network" "nv_siemens_vnet" {
  resource_group_name = azurerm_resource_group.nv_siemens.name
  location            = var.location
  name                = "nv_siemens_vnet"
  address_space       = ["10.44.1.0/24"]
  tags                = merge(var.default_tags, {})
  dns_servers         = ["10.40.250.4", "10.40.250.5"]
}

# siemens subnets
resource "azurerm_subnet" "siemens_fs20_fire" {
  resource_group_name  = azurerm_resource_group.nv_siemens.name
  virtual_network_name = azurerm_virtual_network.nv_siemens_vnet.name
  name                 = "siemens_fs20_fire"
  address_prefix       = "10.44.1.0/27"
}

# siemens subnets
resource "azurerm_subnet" "siemens_cameras" {
  resource_group_name  = azurerm_resource_group.nv_siemens.name
  virtual_network_name = azurerm_virtual_network.nv_siemens_vnet.name
  name                 = "siemens_cameras"
  address_prefix       = "10.44.1.32/27"
}

# siemens subnets
resource "azurerm_subnet" "siemens_spc_controllers" {
  resource_group_name  = azurerm_resource_group.nv_siemens.name
  virtual_network_name = azurerm_virtual_network.nv_siemens_vnet.name
  name                 = "siemens_spc_controllers"
  address_prefix       = "10.44.1.64/27"
}

# siemens subnets
resource "azurerm_subnet" "siemens_sipass_controllers" {
  resource_group_name  = azurerm_resource_group.nv_siemens.name
  virtual_network_name = azurerm_virtual_network.nv_siemens_vnet.name
  name                 = "siemens_sipass_controllers"
  address_prefix       = "10.44.1.96/27"
}

resource "azurerm_subnet" "siemens_system_subnet" {
  resource_group_name  = azurerm_resource_group.nv_siemens.name
  virtual_network_name = azurerm_virtual_network.nv_siemens_vnet.name
  name                 = "siemens_system_subnet"
  address_prefix       = "10.44.1.128/26"
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_virtual_network_peering" "nv_siemens_to_nv-hub" {
  name                         = "nv_siemens_to_nv-hub"
  resource_group_name          = azurerm_resource_group.nv_siemens.name
  virtual_network_name         = azurerm_virtual_network.nv_siemens_vnet.name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}

resource "azurerm_subnet" "azure_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.nv_siemens.name
  virtual_network_name = azurerm_virtual_network.nv_siemens_vnet.name
  address_prefix       = "10.44.1.192/27"
}

