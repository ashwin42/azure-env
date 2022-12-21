locals {
  subscription_name                         = "NV-BI-Prod"
  azurerm_subscription_id                   = "e7e87268-c6b6-415a-877c-2333a99c7c86"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

