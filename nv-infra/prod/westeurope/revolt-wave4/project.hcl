locals {
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "Revolt Wave4"
    jira                 = "TOC-1208"
  }
}
