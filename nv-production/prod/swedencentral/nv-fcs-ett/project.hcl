locals {
  azurerm_provider_version   = ">=3.40.0"
  terraform_required_version = ">= 1.3.7"
  azurerm_features           = {}
  setup_prefix               = basename(get_terragrunt_dir())
  resource_group_name        = "${local.setup_prefix}-rg"

  tags = {
    business-unit = "Production FA1"
    department = "225001 Manufacturing Management"
    cost-center = "225001001 Manufacturing Management"
    region = "swedencentral"
    project = "FA1-5876"
    environment = "prod"
  }
}

