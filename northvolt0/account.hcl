locals {
  subscription_name                 = basename(get_parent_terragrunt_dir())
  subscription_id                   = "f23047bd-1342-4fdf-a81c-00c91500455f"
  remote_state_storage_account_name = "nvtfstate"
  remote_state_container_name       = "nv-tf-state"
  remote_state_resource_group_name  = "nv-core"
  azurerm_provider_version          = "=1.44.0"
  terraform_required_version        = ">= 0.12.29, < 0.13"
  azurerm_features                  = ""
}
