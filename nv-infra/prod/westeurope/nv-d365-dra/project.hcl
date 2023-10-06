locals {
  resource_group_name = "${basename(get_terragrunt_dir())}-rg"
  recovery_vault_name = "${basename(get_terragrunt_dir())}-rv"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project = "D365 DRA"
    jira    = "TOC-1284"
  }
}

