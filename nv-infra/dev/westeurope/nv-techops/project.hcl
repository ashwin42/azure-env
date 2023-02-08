locals {
  azurerm_provider_version   = ">=3.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = {}
  setup_prefix               = "nv-techops"
  resource_group_name        = "techops-rg"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
  }
}
