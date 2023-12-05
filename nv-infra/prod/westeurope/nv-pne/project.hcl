locals {
  azurerm_provider_version   = ">= 2.94"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  netbox_role                = "pne-tc"
  data_collection_rule_names = [
    "wvd_login_auditing-dcr"
  ]

  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    system-owner            = "camille.blanchet@northvolt.com"
    business-unit           = "104 R&D AB"
    department              = "113049 P&L Facility - AB"
    cost-center             = "113049074 P&L Facility AB"
    project                 = "PNE Cyclers VMs"
    jira                    = "TOC-1596"
    recovery-time-objective = "High Priority"
  }
}
