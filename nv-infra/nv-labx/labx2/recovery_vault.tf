resource "azurerm_recovery_services_vault" "nv-labx2" {
  name                = "nv-labx2-recovery-vault"
  location            = var.location
  resource_group_name = azurerm_resource_group.nv_labx2.name
  sku                 = "Standard"
  tags                = merge(var.default_tags, {})
}

#resource "azurerm_management_lock" "azurerm_recovery_services_vault" {
#  count      = var.lock_resources ? 1 : 0
#  name       = "${var.setup_prefix}-recovery_services_vault-ml"
#  scope      = azurerm_recovery_services_vault.this.id
#  lock_level = "CanNotDelete"
#  notes      = "Locked because it's a core component"
#}
#
#resource "azurerm_backup_policy_vm" "daily" {
#  name                = "daily"
#  resource_group_name = azurerm_resource_group.nv_labx2.name
#  recovery_vault_name = azurerm_recovery_services_vault.nv-labx2.name
#
#  backup {
#    frequency = "Daily"
#    time      = "23:00"
#  }
#
#  retention_daily {
#    count = 30
#  }
#
#  retention_weekly {
#    count    = 12
#    weekdays = ["Sunday"]
#  }
#
#  retention_monthly {
#    count    = 12
#    weekdays = ["Sunday"]
#    weeks    = ["Last"]
#  }
#
#  retention_yearly {
#    count    = 1
#    weekdays = ["Sunday"]
#    weeks    = ["Last"]
#    months   = ["December"]
#  }
#}

