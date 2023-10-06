locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = {}
  setup_prefix               = basename(get_terragrunt_dir())
  resource_group_name        = "${local.setup_prefix}-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "Honeywell"
    jira                 = "TOC-1367"
    business-unit        = "232 - Downstream 2 - ET"
    department           = "232002 - DS2 Wet Electrode - ET"
    cost-center          = "232002001 DS2 Wet Electrode General - ET"
    project              = "Honeywell"
    jira                 = "TOC-1367"
  }
}

