locals {
  azurerm_provider_version   = "~> 2.99"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  tags = {
    project = "Print Gateway"
    jira    = "TOC-1208"
  }
}
