resource "azurerm_resource_group" "nv_siemens" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, {})
}

resource "azurerm_management_lock" "nv_siemens_lock" {
  name       = "nv_siemens_lock"
  scope      = azurerm_resource_group.nv_siemens.id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's a core component"
}


resource "azurerm_network_security_group" "nv_siemens_nsg" {
  name                = "nv_siemens_nsg"
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "Allow_Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
