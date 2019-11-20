resource "azurerm_virtual_network" "wuxi-vnet" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "wuxi-vnet"
  address_space       = ["10.42.0.0/24"]
  tags                = merge(var.default_tags, {})
}

resource "azurerm_subnet" "wuxi-subnet" {
  name                 = "wuxi-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.wuxi-vnet.name
  address_prefix       = "10.42.0.0/24"
}

resource "azurerm_network_interface" "main" {
  name                      = "${var.name}-nic"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  network_security_group_id = azurerm_network_security_group.FLP1PAHTS01KED1-nsg.id

  ip_configuration {
    name                          = "${var.name}-nic_config"
    subnet_id                     = azurerm_subnet.wuxi-subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.ipaddress}"
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
  resource_group_name = "${azurerm_resource_group.nv-wuxi-lead.name}"
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "FLP1PAHTS01KED1-nsg" {
  name                = "FLP1PAHTS01KED1-nsg"
  location            = var.location
  resource_group_name = "${azurerm_resource_group.nv-wuxi-lead.name}"

  security_rule {
    name                       = "kyle"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
/* security_rule {
    name                       = "kyle"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "85.30.130.73"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "tempoffice"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "62.20.55.58"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "barracks"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "155.4.206.91"
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "ClientIPAddress_2019-9-25_17-8-5"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "31.208.18.58"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ClientIPAddress_2019-9-26_8-55-57"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "62.20.55.58"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "train"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "185.224.57.161"
    destination_address_prefix = "*"
  }

   security_rule {
    name                       = "wuxi-hotel"
    priority                   = 106
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "31.208.13.131"
    destination_address_prefix = "*"
  }  

   security_rule {
    name                       = "wuxi-team"
    priority                   = 107
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "83.233.65.157"
    destination_address_prefix = "*"
  }  
} */
