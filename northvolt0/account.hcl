locals {
  subscription_name                         = basename(get_parent_terragrunt_dir())
  subscription_id                           = "f23047bd-1342-4fdf-a81c-00c91500455f"
  azurerm_subscription_id                   = "f23047bd-1342-4fdf-a81c-00c91500455f"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = "nvtfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-core"
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
}

