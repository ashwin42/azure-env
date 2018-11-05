# Virtual Network

resource "azurerm_virtual_network" "virtual_network" {
    name                = "${var.application_name}_virtual_network"
    resource_group_name = "${var.resource_group_name}"
    address_space       = "${var.virtual_network_address_space}"
    location            = "${var.location}"
}

resource "azurerm_subnet" "app_subnet" {
    name                 = "app_subnet"
    resource_group_name  = "${var.resource_group_name}"
    virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
    address_prefix       = "${var.subnet_address_prefix}"
}


# VPN

resource "azurerm_subnet" "gateway_subnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = "${var.resource_group_name}"
    virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
    address_prefix       = "${var.gateway_subnet_address_prefix}"
}

resource "azurerm_public_ip" "virtual_network_gateway_public_ip" {
    name                         = "${var.application_name}_virtual_network_gateway_public_ip"
    resource_group_name          = "${var.resource_group_name}"
    location                     = "${var.location}"
    public_ip_address_allocation = "dynamic"
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
    name                = "${azurerm_virtual_network.virtual_network.name}_gateway"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"

    type                = "Vpn"
    vpn_type            = "PolicyBased"

    active_active       = false
    enable_bgp          = false
    sku                 = "Basic"

    ip_configuration {
        name                          = "${azurerm_virtual_network.virtual_network.name}_gateway_config"
        public_ip_address_id          = "${azurerm_public_ip.virtual_network_gateway_public_ip.id}"
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = "${azurerm_subnet.gateway_subnet.id}"
    }
}

resource "azurerm_virtual_network_gateway_connection" "site_to_site_gateway_connection" {
    name                       = "${azurerm_virtual_network_gateway.virtual_network_gateway.name}_site_to_site_vpn"
    location                   = "${var.location}"
    resource_group_name        = "${var.resource_group_name}"

    type                       = "IPsec"
    virtual_network_gateway_id = "${azurerm_virtual_network_gateway.virtual_network_gateway.id}"
    local_network_gateway_id   = "${var.northvolt_gamla_brogatan_26_local_network_gateway_id}"

    shared_key                 = "${var.gateway_connection_psk}"
}


# Security group for VM

resource "azurerm_network_security_group" "security_group" {
    name                = "${var.application_name}_security_group"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
}

resource "azurerm_network_security_rule" "security_rule_ssh" {
  name                        = "${azurerm_network_security_group.security_group.name}_security_rule_ssh"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.security_group.name}"

  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_network_interface" "network_interface" {
    name                      = "${azurerm_network_security_group.security_group.name}_network_interface"
    resource_group_name       = "${var.resource_group_name}"
    location                  = "${var.location}"
    network_security_group_id = "${azurerm_network_security_group.security_group.id}"

    ip_configuration {
        name                          = "${azurerm_network_security_group.security_group.name}_network_interface_ip_configuration"
        subnet_id                     = "${azurerm_subnet.app_subnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}