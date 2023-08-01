locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = {}
  #setup_prefix               = "apis-iq"
  resource_group_name        = "apis-iq-rg"
  recovery_vault_name        = "apis-iq-rv"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109037 IT Common - AB"
    cost-center   = "109037064 IT Common - AB"
    project       = "APIS-IQ"
    jira          = "TOC-1146"
  }
}

