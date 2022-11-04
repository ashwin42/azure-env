locals {
  subscription_id                           = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  azurerm_subscription_id                   = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  azurerm_features                          = {}
  remote_state_azurerm_storage_account_name = "nvinfratfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-infra-core"
  secrets_key_vault_name                    = "nv-infra-core"
  secrets_key_vault_rg                      = "nv-infra-core"
  encryption_key_vault_name                 = "nv-infra-core"
  encryption_key_vault_rg                   = "nv-infra-core"
  ad_join_secrets_key_vault_rg              = "nv-infra-core"
  ad_join_secrets_key_vault_name            = "nv-infra-core"
  ad_join_keyvault_subscription_id          = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  remote_state_azurerm_enabled              = true
  providers                                 = ["azurerm"]
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
