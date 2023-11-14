locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  key_vault_name      = "nv-production-core"
  key_vault_rg        = "nv-production-core"

  tags = {
    infrastructure-owner = "techops@northvolt.com"
    business-unit        = "Business Unit 106 Sustainability - AB"
    department           = "206002 Environment - ET"
    cost-center          = "206002001 HSE - Environment and Energy - ET"
    project              = "PQMS"
    jira                 = "US1-250"
  }
}

