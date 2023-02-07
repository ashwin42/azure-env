locals {
  subscription_name                         = "NV-OOB"
  azurerm_subscription_id                   = "02ad6f5d-b0ee-4fd7-b0ec-fb2aba69839a"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

