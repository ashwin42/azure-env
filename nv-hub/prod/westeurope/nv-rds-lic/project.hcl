locals {
  azurerm_provider_version   = ">=3.2.6"
  terraform_required_version = ">= 1.2.6"
  azurerm_features           = {}
  setup_prefix               = "nv-rds-lic"
  resource_group_name        = "nv-rds-lic"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109037 IT Common - AB"
    cost-center   = "109037064 IT Common - AB"
  }
}

