locals {
  azurerm_provider_version   = ">=3.27.0"
  terraform_required_version = ">= 1.2.6"
  azurerm_features           = {}
  resource_group_name        = "ms-oda-rg"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "1109037 IT Common - AB"
    cost-center   = "109037064 IT Common - AB"
  }
}

