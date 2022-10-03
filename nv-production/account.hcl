locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  azurerm_subscription_id                   = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = "nvproductiontfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-production-core"
  log_analytics_workspace_id                = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/log_analytics-rg/providers/Microsoft.OperationalInsights/workspaces/nv-hub-analytics-log"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

