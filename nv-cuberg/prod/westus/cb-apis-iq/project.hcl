locals {
  azurerm_provider_version   = "~> 3.34.0"
  terraform_required_version = ">= 1.3.7"
  azurerm_features           = {}
  setup_prefix               = "cb-apis-iq"
  resource_group_name        = "cb-apis-iq-rg"
  tags = {
    business-unit = "Cuberg"
    department    = "Cuberg"
    cost-center   = "Cuberg"
  }
}

