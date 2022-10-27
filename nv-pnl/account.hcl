locals {
  subscription_name                         = "NV-PNL"
  azurerm_subscription_id                   = "30b428fc-5b94-408c-8c86-73cf2e46200c"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

