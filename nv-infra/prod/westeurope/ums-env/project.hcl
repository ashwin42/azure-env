locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = "features {}"
  setup_prefix               = "ums-env"
  resource_group_name        = "ums-env-rg"
}
