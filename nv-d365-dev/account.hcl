locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "bd728441-1b83-4daa-a72f-91d5dc6284f1"
  azurerm_subscription_id                   = "bd728441-1b83-4daa-a72f-91d5dc6284f1"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = "nvd365tfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-d365-dev-core"
  log_analytics_workspace_id                = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourcegroups/loganalytics-rg/providers/microsoft.operationalinsights/workspaces/log-analytics-ops-ws"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

