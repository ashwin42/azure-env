locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  azurerm_subscription_id                   = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  secrets_key_vault_name                    = "nv-production-core"
  secrets_key_vault_rg                      = "nv-production-core"
  encryption_key_vault_name                 = "nv-prod-core-encryption"
  encryption_key_vault_rg                   = "nv-production-core"
  remote_state_azurerm_storage_account_name = "nvproductiontfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-production-core"
  automation_account_name                   = "nv-production-automation"
  automation_account_rg                     = "nv-production-core"
  automation_account_workspace              = local.automation_account_name
  additional_providers = [
    {
      alias           = "ad_join_keyvault"
      provider        = "azurerm"
      subscription_id = "11dd160f-0e01-4b4d-a7a0-59407e357777"
      blocks = {
        features = {},
      },
    },
    {
      alias           = "localadmin_keyvault"
      provider        = "azurerm"
      subscription_id = local.subscription_id
      blocks = {
        features = {},
      },
    },
    {
      alias           = "that"
      provider        = "azurerm"
      subscription_id = local.subscription_id
      blocks = {
        features = {},
      },
    }
  ]
}

