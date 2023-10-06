locals {
  azurerm_provider_version   = ">= 3.45"
  terraform_required_version = ">= 1.3.7"
  azurerm_features           = {}
  netbox_role                = "condmaster"
  setup_prefix               = basename(get_terragrunt_dir())
  resource_group_name        = "${local.setup_prefix}-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    business-unit        = "226 Maintenance - ET"
    department           = "226001 Maintenance General - ET"
    cost-center          = "226001001 Maintenance General - ET"
    project              = "Condmaster"
    jira                 = "US1-314"
  }
}

