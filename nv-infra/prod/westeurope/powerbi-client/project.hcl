locals {
  azurerm_provider_version   = ">=3.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = "features {}"
  setup_prefix               = "powerbi-client"
  resource_group_name        = "powerbi-client-rg"
}
