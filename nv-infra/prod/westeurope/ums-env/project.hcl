locals {
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  setup_prefix               = "ums-env"
  resource_group_name        = "ums-env-rg"
  tags = {
    project = "UMS"
    jira    = "TOC-787"
  }
}
