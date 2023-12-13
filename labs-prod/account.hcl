locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  azurerm_subscription_id                   = "82f99951-a219-463b-97ff-011a0d6e28a4"
  subscription_id                           = "82f99951-a219-463b-97ff-011a0d6e28a4"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("nv${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  bootdiag_storage_account_name             = replace(lower("nv${local.subscription_name}bootdiag"), "/[-_]/", "")
  secrets_key_vault_name                    = "${local.subscription_name}-secrets"
  secrets_key_vault_rg                      = "${basename(get_terragrunt_dir())}-general-rg"
  encryption_key_vault_name                 = "${local.subscription_name}-encrypt"
  encryption_key_vault_rg                   = "${basename(get_terragrunt_dir())}-general-rg"
  ad_join_secrets_key_vault_rg              = "nv-infra-core"
  ad_join_secrets_key_vault_name            = "nv-infra-core"
  ad_join_keyvault_subscription_id          = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  automation_account_name                   = "${basename(get_terragrunt_dir())}-automation"
  automation_account_rg                     = "${basename(get_terragrunt_dir())}-general-rg"
  automation_account_workspace              = local.automation_account_name
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
  additional_providers = [
    {
      alias           = "ad_join_keyvault"
      provider        = "azurerm"
      subscription_id = local.ad_join_keyvault_subscription_id
      blocks = {
        features = {},
      },
    },
    {
      alias           = "localadmin_keyvault"
      provider        = "azurerm"
      subscription_id = "82f99951-a219-463b-97ff-011a0d6e28a4"
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

}

