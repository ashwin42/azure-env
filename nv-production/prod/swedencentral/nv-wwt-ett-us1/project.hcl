locals {
  azurerm_provider_version   = ">=3.45"
  terraform_required_version = ">= 1.3.7"
  azurerm_features           = {}
  netbox_role                = "wwt"
  setup_prefix               = basename(get_terragrunt_dir())
  resource_group_name        = "${local.setup_prefix}-rg"
  tags = {
    project = "Waste Water Treatment"
    jira    = "TOC-858"
  }
}

