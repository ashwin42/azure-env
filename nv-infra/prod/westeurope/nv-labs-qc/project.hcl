locals {
  azurerm_provider_version   = ">= 3.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  setup_prefix               = basename(get_terragrunt_dir())
  tags = {
    business-unit = "151058 Quality Control - LA"
    department    = "151 Manufacturing Support - LA"
    cost-center   = "151058251 Quality Control - LA"
  }
}

