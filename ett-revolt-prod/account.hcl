locals {
  subscription_name                         = "ett-revolt-prod"
  azurerm_subscription_id                   = "f652c928-a8cb-4d8f-9175-bbe0a0128eb0"
  secrets_key_vault_name                    = "${local.subscription_name}-secrets"
  encryption_key_vault_name                 = "${local.subscription_name}-encrypt"
  bootdiag_storage_account_name             = replace(lower("${local.subscription_name}bootdiag"), "/[-_]/", "")
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
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
      subscription_id = "f652c928-a8cb-4d8f-9175-bbe0a0128eb0"
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

