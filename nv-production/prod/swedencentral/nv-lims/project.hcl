locals {
  azurerm_provider_version   = ">= 3.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  setup_prefix               = basename(get_terragrunt_dir())
  resource_group_name        = "${local.setup_prefix}-rg"
  netbox_role                = "lims"
  install_winrm              = true
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "Lims"
    jira                    = "TOC-1210"
    business-unit           = "109 - Digitalization IT - AB"
    department              = "109033 - Business Systems"
    cost-center             = "109033056 - LIMS"
    system-owner            = "per.spaak@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}

