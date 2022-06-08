locals {
  subscription_name                  = basename(get_parent_terragrunt_dir())
  subscription_id                    = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  remote_state_storage_account_name  = "nvinfratfstate"
  remote_state_container_name        = "nv-tf-state"
  remote_state_resource_group_name   = "nv-infra-core"
  azurerm_provider_version           = "=2.49.0"
  terraform_required_version         = ">= 0.12.29, < 0.13"
  azurerm_features                   = "features {}"
  secrets_key_vault_name             = "nv-infra-core"
  secrets_key_vault_rg               = "nv-infra-core"
  encryption_key_vault_name          = "nv-infra-core"
  encryption_key_vault_rg            = "nv-infra-core"
  default_log_analytics_workspace_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourcegroups/core_utils/providers/microsoft.operationalinsights/workspaces/nv-hub-analytics-log"
}
