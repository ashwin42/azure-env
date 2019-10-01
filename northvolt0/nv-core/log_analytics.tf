resource "azurerm_log_analytics_workspace" "nv-core" {
  name                = "nv-core-log-analytics"
  location            = "${azurerm_resource_group.nv-core.location}"
  resource_group_name = "${azurerm_resource_group.nv-core.name}"
  sku                 = "PerGB2018"
  retention_in_days   = 120

  tags = {
      terraform = true
  }
}