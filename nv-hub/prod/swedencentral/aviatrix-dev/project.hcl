locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = "features {}"
  setup_prefix               = "avx-dev-sc"
  resource_group_name        = "avx-dev-sc-rg"
  environment                = "dev"
}
