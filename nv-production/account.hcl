locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  azurerm_subscription_id                   = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = "nvproductiontfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-production-core"
  terraform_required_version                = ">= 1.1.5"
  providers                                 = ["azurerm"]
  azurerm_provider_version                  = ">= 2.95.0"
  azurerm_features                          = {}
}

