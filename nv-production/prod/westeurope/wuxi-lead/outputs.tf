output "vm_id" {
  value = azurerm_virtual_machine.main.id
}

output "ip_address" {
  value = azurerm_network_interface.main.private_ip_address
}
