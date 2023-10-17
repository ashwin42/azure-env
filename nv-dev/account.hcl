locals {
  subscription_name                         = "NV-Dev"
  azurerm_subscription_id                   = "3540c34b-4446-4708-bddf-f701543443eb"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  default_rg                                = "nv-dev-rg"
  secrets_key_vault_name                    = "nvdevsecretsvault"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

