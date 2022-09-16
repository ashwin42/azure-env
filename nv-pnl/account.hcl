locals {
  subscription_name                         = "NV-PNL"
  azurerm_subscription_id                   = "30b428fc-5b94-408c-8c86-73cf2e46200c"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  log_analytics_workspace_id                = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/log_analytics-rg/providers/Microsoft.OperationalInsights/workspaces/nv-hub-analytics-log"
  terraform_required_version                = ">= 1.0"
  providers                                 = ["azurerm"]
  azurerm_provider_version                  = ">=2.95.0"
  azurerm_features                          = {}
}

