locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = {}
  setup_prefix               = "octoplant-labs"
  resource_group_name        = "nv-octoplant-labs-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project = "Octoplant"
    jira    = "TOC-1094"
  }
}
