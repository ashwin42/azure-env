resource "azurerm_recovery_services_vault" "nv-labx2" {
  name                = var.recovery_vault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.nv_labx2.name
  sku                 = "Standard"
}

resource "azurerm_recovery_services_protection_policy_vm" "daily" {
  name                = "daily"
  resource_group_name = var.recovery_vault_resource_group
  recovery_vault_name = azurerm_recovery_services_vault.nv-labx2.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 30
  }

  retention_weekly {
    count    = 12
    weekdays = ["Sunday"]
  }

  retention_monthly {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["Last"]
  }

  retention_yearly {
    count    = 1
    weekdays = ["Sunday"]
    weeks    = ["Last"]
    months   = ["December"]
  }
}

output "recovery_services" {
  value = {
    recovery_vault_name        = "${azurerm_recovery_services_vault.nv-labx2.name}"
    protection_policy_daily_id = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
  }
}
