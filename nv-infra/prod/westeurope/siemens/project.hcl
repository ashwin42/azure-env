locals {
  azurerm_provider_version   = "~> 2.99.0"
  terraform_required_version = ">=1.1.5"
  azurerm_features           = {}

  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035063 Operations & Infrastructure Common - AB"
  }
}
