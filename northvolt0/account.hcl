locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "f23047bd-1342-4fdf-a81c-00c91500455f"
  azurerm_subscription_id                   = "f23047bd-1342-4fdf-a81c-00c91500455f"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = "nvtfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-core"
  log_analytics_workspace_id                = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/log_analytics-rg/providers/Microsoft.OperationalInsights/workspaces/nv-hub-analytics-log"
  azurerm_provider_version                  = "=1.44.0"
  terraform_required_version                = ">= 0.12.29, < 0.13"
  providers                                 = ["azurerm"]
  azurerm_features                          = ""
}

