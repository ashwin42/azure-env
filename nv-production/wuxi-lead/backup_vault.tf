resource "azurerm_recovery_services_vault" "FL-P1-PA-HTS01-KED01" {
  name                = "FL-P1-PA-HTS01-KED01-recovery-vault"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
}

resource "azurerm_recovery_services_protection_policy_vm" "daily" {
  name                = "daily"
  resource_group_name = "${var.resource_group_name}"
  recovery_vault_name = "${azurerm_recovery_services_vault.FL-P1-PA-HTS01-KED01.name}"

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
    recovery_vault_name        = "${azurerm_recovery_services_vault.FL-P1-PA-HTS01-KED01.name}"
    protection_policy_daily_id = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
  }
}
