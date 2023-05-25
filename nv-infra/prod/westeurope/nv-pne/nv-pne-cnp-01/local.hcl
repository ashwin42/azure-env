locals {
  azurerm_provider_version   = "= 3.54"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  data_collection_rule_names = [
    "wvd_login_auditing-dcr"
  ]

  tags = {
    business-unit = "104 R&D AB"
    department    = "104019 R&D Lab - AB"
    cost-center   = "104019014 R&D Lab - AB"
  }
}

