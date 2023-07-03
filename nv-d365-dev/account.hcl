locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "bd728441-1b83-4daa-a72f-91d5dc6284f1"
  azurerm_subscription_id                   = "bd728441-1b83-4daa-a72f-91d5dc6284f1"
  secrets_key_vault_name                    = "nv-d365-dev-we-secrets"
  secrets_key_vault_rg                      = "nv-d365-dev-core"
  encryption_key_vault_name                 = "nv-d365-dev-encryption"
  encryption_key_vault_rg                   = "nv-d365-dev-core"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = "nvd365tfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-d365-dev-core"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
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

