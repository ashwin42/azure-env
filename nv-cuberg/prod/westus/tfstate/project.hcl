locals {
  setup_prefix               = basename(get_terragrunt_dir())
  azurerm_provider_version   = "~> 3.34.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
  }
}

