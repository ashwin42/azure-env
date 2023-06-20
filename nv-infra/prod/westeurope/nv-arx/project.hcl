locals {
  azurerm_provider_version   = ">= 2.31.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  tags = {
    project = "ARX"
    jira    = "TOC-1208"
  }
}
