locals {
  resource_group_name           = "nv_labx"
  recovery_vault_name           = "labx-rv"
  recovery_vault_resource_group = "nv_labx"
  delete_files                  = ["provider.tf"]
  azurerm_provider_version      = ">= 3.0"
  terraform_required_version    = ">= 1.0"
  azurerm_features              = {}
  tags = {
    project = "LabX"
    jira    = "TOC-1208"
  }
}
