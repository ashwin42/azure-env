locals {
  azurerm_provider_version   = ">=3.27.0"
  terraform_required_version = ">= 1.2.6"
  azurerm_features           = {}
  setup_prefix               = "${basename(dirname(dirname(dirname(get_terragrunt_dir()))))}-${basename(get_terragrunt_dir())}"
  resource_group_name        = "${local.setup_prefix}-rg"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
  }
}

