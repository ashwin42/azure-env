locals {
  subscription_name                         = "NV-PNL"
  azurerm_subscription_id                   = "30b428fc-5b94-408c-8c86-73cf2e46200c"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  log_analytics_workspace_id                = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourcegroups/loganalytics-rg/providers/microsoft.operationalinsights/workspaces/log-analytics-ops-ws"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

