locals {
  subscription_name                         = "NV-Dwa-Infra"
  azurerm_subscription_id                   = "8fd2d16b-30ef-4fd1-b2f2-0df001fd747d"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  log_analytics_workspace_id                = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/log_analytics-rg/providers/Microsoft.OperationalInsights/workspaces/nv-hub-analytics-log"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

