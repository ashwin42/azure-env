locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  azurerm_features           = {}
  setup_prefix               = "nv-plc-ews"
  resource_group_name        = "nv-plc-ews-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project = "PLC Engineering Workstations"
    jira    = "TOC-1001"
  }
}
