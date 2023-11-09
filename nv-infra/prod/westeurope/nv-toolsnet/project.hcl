locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = {}
  setup_prefix               = "nv-toolsnet"
  resource_group_name        = "nv-toolsnet-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    system-owner         = "nikhil.ravi@northvolt.com"
    business-unit        = "250 Northvolt Battery Systems - BS"
    department           = "250006 Manufacturing & Industrialization Engineering - BS"
    cost-center          = "250006024 Manufacturing Process Engineering - BS"
    project              = "Toolsnet"
    jira                 = "TOC-1023"
  }
}
