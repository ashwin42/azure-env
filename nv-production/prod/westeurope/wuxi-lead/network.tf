resource "azurerm_virtual_network" "wuxi-vnet" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "wuxi-vnet"
  address_space       = ["10.42.0.0/24"]
  tags                = merge(var.default_tags, {})
}

resource "azurerm_subnet" "wuxi-subnet" {
  name                                           = "wuxi-subnet"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.wuxi-vnet.name
  address_prefixes                               = ["10.42.0.0/24"]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_private_endpoint" "nv_wuxi_sql_pe" {
  name                = "nv_wuxi_sql_pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.wuxi-subnet.id

  private_service_connection {
    name                           = "nv_wuxi_sql_pe"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_sql_server.nv-wuxi-lead.id
    subresource_names              = ["sqlServer"]
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${var.name}-nic_config"
    subnet_id                     = azurerm_subnet.wuxi-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.ipaddress
    public_ip_address_id          = azurerm_public_ip.FLP1PAHTS01KED1.id
  }
}

resource "azurerm_virtual_network_peering" "wuxi-vnet_to_nv-hub" {
  name                         = "wuxi-vnet_to_nv-hub"
  resource_group_name          = azurerm_resource_group.nv-wuxi-lead.name
  virtual_network_name         = azurerm_virtual_network.wuxi-vnet.name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}

resource "azurerm_public_ip" "FLP1PAHTS01KED1" {
  name                = "FLP1PAHTS01KED1-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "FLP1PAHTS01KED1-nsg" {
  name                = "FLP1PAHTS01KED1-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name

  security_rule {
    name                       = "Temp_Office"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "62.20.55.58"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Factory"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "213.50.54.192/28"
    destination_address_prefix = "*"
  }

  security_rule {
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "*"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "AwsInbound"
    priority                                   = 110
    protocol                                   = "*"
    source_address_prefix                      = "10.21.0.0/16"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
  }

  security_rule {
    name                       = "Labs_Telia"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "62.20.23.0/28"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.FLP1PAHTS01KED1-nsg.id
}

