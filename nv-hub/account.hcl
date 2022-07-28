locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  azurerm_subscription_id                   = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  remote_state_azurerm_storage_account_name = "nvhubtfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-hub-core"
  secrets_key_vault_name                    = "vm-secrets-kv"
  secrets_key_vault_rg                      = "vm-secrets-kv-rg"
  encryption_key_vault_name                 = "nv-swc-hub-vm-enc-kv"
  encryption_key_vault_rg                   = "nv-swc-hub-vm-enc-kv-rg"
  log_analytics_workspace_id                = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/log_analytics-rg/providers/Microsoft.OperationalInsights/workspaces/nv-hub-analytics-log"
  azurerm_provider_version                  = ">=2.94.0"
  terraform_required_version                = ">=0.1.5"
  azurerm_features                          = {}
  remote_state_azurerm_enabled              = true
  providers                                 = ["azurerm"]
}
