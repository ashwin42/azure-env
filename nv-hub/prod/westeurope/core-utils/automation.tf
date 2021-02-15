resource "azurerm_automation_account" "nv-hub-automation" {
  name                = "nv-hub-automation"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "Basic"

}

resource "azurerm_log_analytics_workspace" "nv-hub-analytics-log" {
  name                = "nv-hub-analytics-log"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_linked_service" "nv-law-link" {
  resource_group_name = var.resource_group_name
  workspace_name      = azurerm_log_analytics_workspace.nv-hub-analytics-log.name
  resource_id         = azurerm_automation_account.nv-hub-automation.id
}
