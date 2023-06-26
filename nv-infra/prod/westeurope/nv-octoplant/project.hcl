locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = {}
  setup_prefix               = "nv-octoplant"
  resource_group_name        = "nv-octoplant-rg"
  tags = {
    project = "Octoplant"
    jira    = "TOC-1094"
  }
}
