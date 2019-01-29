output "virtual_network_name" {
  value = "${azurerm_virtual_network.virtual_network.name}"
}

output "subnet_internal_id" {
  value = "${azurerm_subnet.subnet_internal.id}"
}

output "subnet_internal_prefix" {
  value = "${azurerm_subnet.subnet_internal.address_prefix}"
}

output "gateway_subnet_id" {
  value = "${azurerm_subnet.gateway_subnet.id}"
}

output "gamla_brogatan_26_local_gateway" {
  value = "${azurerm_local_network_gateway.gamla_brogatan_26_local_gateway.id}"
}
