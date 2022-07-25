locals {
  azurerm_provider_version   = "~> 3.15"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  setup_prefix               = "powerbi-client"
  resource_group_name        = "powerbi-client-rg"
}
