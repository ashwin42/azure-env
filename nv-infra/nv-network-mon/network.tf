resource "azurerm_public_ip" "nv-network-mon" {
  name                = "nv-network-mon-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                      = "${var.name}-nic"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.nv_network_mon_nsg.id

  ip_configuration {
    name                          = "${var.name}-nic_config"
    subnet_id                     = azurerm_subnet.nv_network_mon_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = azurerm_public_ip.nv-network-mon.id
  }
}

# nv_network_mon vnet
resource "azurerm_virtual_network" "nv_network_mon_vnet" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "nv_network_mon_vnet"
  address_space       = ["10.44.3.0/24"]
  dns_servers         = ["10.40.250.4", "10.40.250.5"]
}

# nv_network_mon subnets
resource "azurerm_subnet" "nv_network_mon_subnet" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.nv_network_mon_vnet.name
  name                 = "nv_network_mon_subnet"
  address_prefix       = "10.44.3.0/27"
}

# nv_network_nps subnets
resource "azurerm_subnet" "nv_nps_subnet" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.nv_network_mon_vnet.name
  name                 = "nv_nps_subnet"
  address_prefix       = "10.44.3.32/27"
}

resource "azurerm_virtual_network_peering" "nv_network_mon_to_nv-hub" {
  name                         = "nv_network_mon_to_nv-hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.nv_network_mon_vnet.name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}

