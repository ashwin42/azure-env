locals {
  subscription_name                         = "NV-PNL"
  subscription_id                           = "30b428fc-5b94-408c-8c86-73cf2e46200c"
  azurerm_subscription_id                   = "30b428fc-5b94-408c-8c86-73cf2e46200c"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  secrets_key_vault_name                    = "nv-pnl-we-secrets"
  secrets_key_vault_rg                      = "global-rg"
  encryption_key_vault_name                 = "nv-pnl-we-encryption"
  encryption_key_vault_rg                   = "global-rg"
  ad_join_secrets_key_vault_rg              = "nv-infra-core"
  ad_join_secrets_key_vault_name            = "nv-infra-core"
  ad_join_keyvault_subscription_id          = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
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

