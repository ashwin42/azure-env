locals {
  subscription_name                 = basename(get_parent_terragrunt_dir())
  subscription_id                   = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  remote_state_storage_account_name = "nvinfratfstate"
  remote_state_container_name       = "nv-tf-state"
  remote_state_resource_group_name  = "nv-infra-core"
  azurerm_provider_version          = "=2.49.0"
  terraform_required_version        = ">= 0.12.29, < 0.13"
  azurerm_features                  = "features {}"
}
