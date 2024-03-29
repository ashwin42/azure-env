locals {
  recovery_vault_name = "${basename(get_terragrunt_dir())}-rv"
  resource_group_name = "${basename(get_terragrunt_dir())}-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    system-owner         = "samantha.transfeld@northvolt.com"
    business-unit        = "109 Digitalization IT - AB"
    department           = "109034 - Enterprise Architecture"
    cost-center          = "109034056 - Enterprise Architecture"
    project              = "Ataccama Dev"
    jira                 = "TOC-1880"
  }
}

