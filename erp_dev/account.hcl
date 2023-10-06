locals {
  subscription_name                         = "erp_dev"
  subscription_id                           = "2a42c4da-13f8-4cff-be34-3d05a20282e6"
  azurerm_subscription_id                   = "2a42c4da-13f8-4cff-be34-3d05a20282e6"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  encryption_key_vault_name                 = "nv-erp-dev-we-encryption"
  encryption_key_vault_rg                   = "global-rg"
  secrets_key_vault_name                    = "nv-erp-dev-we-secrets"
  secrets_key_vault_rg                      = "global-rg"
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
      subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      blocks = {
        features = {},
      },
    },
  ]

  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109033 Business Systems"
    cost-center   = "109033054 ERP & Microsoft"
  }
}

