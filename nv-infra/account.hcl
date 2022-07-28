locals {
  terraform_required_version = ">= 0.12.29"
  #subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  azurerm_subscription_id                   = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  azurerm_provider_version                  = ">= 2.49.0"
  azurerm_features                          = {}
  remote_state_azurerm_storage_account_name = "nvinfratfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-infra-core"
  secrets_key_vault_name                    = "nv-infra-core"
  secrets_key_vault_rg                      = "nv-infra-core"
  encryption_key_vault_name                 = "nv-infra-core"
  encryption_key_vault_rg                   = "nv-infra-core"
  log_analytics_workspace_id                = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/log_analytics-rg/providers/Microsoft.OperationalInsights/workspaces/nv-hub-analytics-log"
  remote_state_azurerm_enabled              = true
  providers                                 = ["azurerm"]
}

