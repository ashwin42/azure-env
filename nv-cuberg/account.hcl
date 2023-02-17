locals {
  subscription_name                         = "NV-Cuberg"
  subscription_id                           = "c2a288a2-6082-4f64-b1a0-1a82d0dde154"
  azurerm_subscription_id                   = "c2a288a2-6082-4f64-b1a0-1a82d0dde154"
  azurerm_features                          = {}
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  secrets_key_vault_name                    = "nvcuberginfrasecrets"
  secrets_key_vault_rg                      = "global-rg"
  encryption_key_vault_name                 = "nvcuberginfraencryption"
  encryption_key_vault_rg                   = "global-rg"
  ad_join_secrets_key_vault_rg              = "nv-infra-core"
  ad_join_secrets_key_vault_name            = "nv-infra-core"
  ad_join_keyvault_subscription_id          = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  providers                                 = ["azurerm"]
  additional_providers = [
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

