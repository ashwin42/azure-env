locals {
  azurerm_provider_version         = ">=3.23.0"
  terraform_required_version       = ">= 1.2.6"
  azurerm_features                 = {}
  setup_prefix                     = "nv-pnl"
  resource_group_name              = "nv-pnl-vms-rg"
  location                         = "westeurope"
  loganalytics_resource_group_name = "loganalytics-rg" ## remove this line once pne vms are moved to new wvd module
  data_collection_rule_names = [
    "wvd_login_auditing-dcr"
  ]

  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "PNE Cycler VMs"
    business-unit        = "104 R&D AB"
    department           = "113049 P&L Facility - AB"
    cost-center          = "113049074 P&L Facility AB"
  }
}

