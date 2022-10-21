locals {
  azurerm_provider_version   = ">=3.23.0"
  terraform_required_version = ">= 1.2.6"
  azurerm_features           = {}
  setup_prefix               = "nv-pnl"
  resource_group_name        = "nv-pnl-vms-rg"
  location                   = "westeurope"
  data_collection_rule_names = [
    "wvd_login_auditing-dcr"
  ]  
}

