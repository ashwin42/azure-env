locals {
  subscription_name                         = "NV-BI-Dev"
  azurerm_subscription_id                   = "4c463b9b-3bc8-465e-ab88-4a5c54498953"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

