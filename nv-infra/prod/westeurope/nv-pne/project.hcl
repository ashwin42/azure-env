locals {
  azurerm_provider_version   = ">= 2.94"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  data_collection_rule_names = [
    "wvd_login_auditing-dcr"
  ]
}
