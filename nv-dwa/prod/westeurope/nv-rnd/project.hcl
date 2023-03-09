locals {
  azurerm_provider_version   = ">= 3.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  setup_prefix               = basename(get_terragrunt_dir())

  tags = {
    business-unit = "306 R&D - PL"
    department    = "306065 R&D - PL"
    cost-center   = "306065083 R&D - PL"
  } 
}

