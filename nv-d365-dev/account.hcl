locals {
  subscription_name                 = basename(get_parent_terragrunt_dir())
  subscription_id                   = "bd728441-1b83-4daa-a72f-91d5dc6284f1"
  remote_state_storage_account_name = "nvd365tfstate"
  remote_state_container_name       = "nv-tf-state"
  remote_state_resource_group_name  = "nv-d365-dev-core"
  azurerm_provider_version          = ">=2.95"
  terraform_required_version        = ">=1.1.5"
  azurerm_features                  = "features {}"
}

