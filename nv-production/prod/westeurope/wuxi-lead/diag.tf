resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "Basic Wuxi diag"
  target_resource_id = azurerm_sql_database.nv-wuxi-prismatic.id
  storage_account_id = azurerm_storage_account.this.id
  log {
    category = "AutomaticTuning"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  log {
    category = "Blocks"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  log {
    category = "DatabaseWaitStatistics"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  log {
    category = "Deadlocks"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  log {
    category = "DevOpsOperationsAudit"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
  log {
    category = "Errors"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  log {
    category = "QueryStoreRuntimeStatistics"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  log {
    category = "QueryStoreWaitStatistics"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  log {
    category = "SQLInsights"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  log {
    category = "SQLSecurityAuditEvents"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
  log {
    category = "Timeouts"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }

  metric {
    category = "Basic"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  metric {
    category = "InstanceAndAppAdvanced"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
  metric {
    category = "WorkloadManagement"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }
}

