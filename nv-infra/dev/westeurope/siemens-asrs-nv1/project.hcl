locals {
  terraform_required_version = ">= 0.13.0"
  azurerm_provider_version   = "~> 2.99"
  azurerm_features           = {}
  tags = {
    project = "Siemens ASRS Dev"
    jira    = "TOC-1208"
  }
}
