locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  azurerm_subscription_id                   = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  remote_state_azurerm_storage_account_name = "nvhubtfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-hub-core"
  secrets_key_vault_name                    = "nv-hub-core"
  secrets_key_vault_rg                      = "nv-hub-core"
  encryption_key_vault_name                 = "nv-swc-hub-vm-enc-kv"
  encryption_key_vault_rg                   = "nv-swc-hub-vm-enc-kv-rg"
  ad_join_secrets_key_vault_rg              = "nv-infra-core"
  ad_join_secrets_key_vault_name            = "nv-infra-core"
  ad_join_keyvault_subscription_id          = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  azurerm_features                          = {}
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
      alias    = "localadmin_keyvault"
      provider = "azurerm"
      blocks = {
        features = {},
      },
    },
    {
      alias    = "keyvault_private_endpoint"
      provider = "azurerm"
      blocks = {
        features = {},
      },
    },
    {
      alias    = "storage_private_endpoint"
      provider = "azurerm"
      blocks = {
        features = {},
      },
    },
  ]
}

