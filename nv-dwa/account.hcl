locals {
  subscription_name                         = "NV-Dwa"
  azurerm_subscription_id                   = "8fd2d16b-30ef-4fd1-b2f2-0df001fd747d"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  ad_join_secrets_key_vault_rg              = "nv-infra-core"
  ad_join_secrets_key_vault_name            = "nv-infra-core"
  secrets_key_vault_name                    = "nvdwainfrasecrets"
  secrets_key_vault_rg                      = "global-rg"
  encryption_key_vault_name                 = "nvdwainfraencryption"
  encryption_key_vault_rg                   = "global-rg"
  automation_account_name                   = "${basename(get_terragrunt_dir())}-automation"
  automation_account_rg                     = "${basename(get_terragrunt_dir())}-general-rg"
  automation_account_workspace              = local.automation_account_name
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
      subscription_id = "8fd2d16b-30ef-4fd1-b2f2-0df001fd747d"
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

