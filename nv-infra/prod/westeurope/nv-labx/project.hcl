locals {
  delete_files               = ["provider.tf"]
  azurerm_provider_version   = ">= 3.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  tags = {
    project = "LabX"
    jira    = "TOC-1208"
  }
}
