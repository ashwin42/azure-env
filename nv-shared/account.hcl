locals {
  subscription_name                         = "NV-Shared"
  azurerm_subscription_id                   = "2a2aa718-5ad8-448a-9ab7-618fc44bb739"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  secrets_key_vault_name                    = "nv-shared-we-secrets"
  secrets_key_vault_rg                      = "general-rg"
  encryption_key_vault_name                 = "nv-shared-we-encryption"
  encryption_key_vault_rg                   = "general-rg"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
  additional_providers = [
    {
      alias           = "that"
      provider        = "azurerm"
      subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      blocks = {
        features = {},
      },
    },
    {
      alias           = "localadmin_keyvault"
      provider        = "azurerm"
      subscription_id = "2a2aa718-5ad8-448a-9ab7-618fc44bb739"
      blocks = {
        features = {},
      },
    },
    {
      alias           = "ad_join_keyvault"
      provider        = "azurerm"
      subscription_id = "11dd160f-0e01-4b4d-a7a0-59407e357777"
      blocks = {
        features = {},
      },
    },
  ]

}

