output "resource_group" {
  value = azurerm_resource_group.abb_800xa
}

output "virtual_network" {
  value = azurerm_virtual_network.abb_800xa
}

output "subnet_1" {
  value = azurerm_subnet.abb_800xa_1
}

output "subnet_2" {
  value = azurerm_subnet.abb_800xa_2
}

output "subnet_3" {
  value = azurerm_subnet.abb_800xa_3
}

output "vnet_peering" {
  value = azurerm_virtual_network_peering.abb800xa_to_nv-hub
}

output "recovery_services" {
  value = {
    recovery_vault_name        = azurerm_recovery_services_vault.main.name
    protection_policy_daily_id = azurerm_recovery_services_protection_policy_vm.daily.id
  }
}
