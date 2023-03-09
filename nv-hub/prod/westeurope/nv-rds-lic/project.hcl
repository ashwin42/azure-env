locals {
  azurerm_provider_version   = ">=3.2.6"
  terraform_required_version = ">= 1.2.6"
  azurerm_features           = {}
  setup_prefix               = "nv-rds-lic"
  resource_group_name        = "nv-rds-lic"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
  }
}

