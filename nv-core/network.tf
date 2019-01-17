# Main vnet for NV Azure
resource "azurerm_virtual_network" "core_vnet" {
  name                = "nv-core-vnet"
  resource_group_name = "${var.resource_group_name}"
  address_space       = "${var.vnet_address_space}"
  location            = "${var.location}"
}

output "core_vnet_id" {
  value = "${azurerm_virtual_network.core_vnet.id}"
}

# Subnets
resource "azurerm_subnet" "nv_shared_1" {
  name                 = "nv-shared-1"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.core_vnet.name}"
  address_prefix       = "10.101.1.0/24"
}

output "subnet_id" {
  value = {
    "nv_shared_1" = "${azurerm_subnet.nv_shared_1.id}"
  }
}
