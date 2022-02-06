locals {
  subscription_name                 = basename(get_parent_terragrunt_dir())
  subscription_id                   = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  remote_state_storage_account_name = "nvhubtfstate"
  remote_state_container_name       = "nv-tf-state"
  remote_state_resource_group_name  = "nv-hub-core"
  azurerm_provider_version          = ">=2.94.0"
  terraform_required_version        = ">=0.1.5"
  azurerm_features                  = "features {}"
}
