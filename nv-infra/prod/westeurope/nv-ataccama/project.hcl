locals {
  azurerm_provider_version   = ">= 3.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  setup_prefix               = basename(get_terragrunt_dir())
  resource_group_name        = "${local.setup_prefix}-rg"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109034 - Enterprise Architecture"
    cost-center   = "109034056 - Enterprise Architecture"
  }
}

