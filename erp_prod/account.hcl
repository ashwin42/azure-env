locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "810a32ab-57c8-430a-a3ba-83c5ad49e012"
  azurerm_subscription_id                   = "810a32ab-57c8-430a-a3ba-83c5ad49e012"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-rg", "/[_]/", "-")
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

