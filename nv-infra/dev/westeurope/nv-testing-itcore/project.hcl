locals {
  azurerm_provider_version   = ">=3.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = "features {}"
  setup_prefix               = "nv-testing-itcore"
  resource_group_name        = "IT-Core-RG"
}
