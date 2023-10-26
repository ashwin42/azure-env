locals {
  resource_group_name           = basename(get_terragrunt_dir())
  recovery_vault_name           = "${local.resource_group_name}-rv"
  recovery_vault_resource_group = local.resource_group_name
  tags = {
    project              = "Veeam"
    jira                 = "TOC-2434"
    infrastructure-owner = "techops@northvolt.com"
    business-unit        = "109 Digitalization IT - AB"
    department           = "109035 Operations & Infrastructure - AB"
    cost-center          = "109035060 TechOps"
    system-owner         = "techops@northvolt.com"
  }
}
