locals {
  azurerm_provider_version   = ">= 3.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  setup_prefix               = basename(get_terragrunt_dir())
}

