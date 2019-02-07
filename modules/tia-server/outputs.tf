output "ip_address" {
  value = "${azurerm_network_interface.tia.private_ip_address}"
}
