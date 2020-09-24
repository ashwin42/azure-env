output "resource_group" {
  value = azurerm_resource_group.nv_labx
}

output "virtual_network" {
  value = azurerm_virtual_network.nv_labx_vnet
}

output "subnet" {
  value = azurerm_subnet.labx_subnet
}

output "vnet_peering" {
  value = azurerm_virtual_network_peering.nv_labx_vnet_to_nv-hub
}

output "recovery_services" {
  value = {
    recovery_vault_name        = azurerm_recovery_services_vault.nv-labx.name
    protection_policy_daily_id = azurerm_recovery_services_protection_policy_vm.daily.id
  }
}

output "azurerm_recovery_services_vault" {
  value = azurerm_recovery_services_vault.nv-labx
}
