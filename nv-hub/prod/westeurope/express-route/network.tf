resource "azurerm_public_ip" "public-er-gw" {
  name                = "public-er-gw"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "nv-hub-er-gw" {
  name                = "nw-hub-er-gw"
  location            = var.location
  resource_group_name = var.resource_group_name

  type = "ExpressRoute"

  sku = "Standard"

  ip_configuration {
    name                 = "er-gw-config"
    public_ip_address_id = azurerm_public_ip.public-er-gw.id
    subnet_id            = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet/subnets/GatewaySubnet"
  }
}

