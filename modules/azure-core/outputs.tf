output "virtual_network_name" {
  value = "${azurerm_virtual_network.virtual_network.name}"
}

output "gamla_brogatan_26_local_gateway" {
  value = "${azurerm_local_network_gateway.gamla_brogatan_26_local_gateway.id}"
}
