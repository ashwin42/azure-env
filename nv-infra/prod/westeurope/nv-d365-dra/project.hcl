locals {
  resource_group_name = "${basename(get_terragrunt_dir())}-rg"
  recovery_vault_name = "${basename(get_terragrunt_dir())}-rv"
  tags = {
    project = "D365 DRA"
    jira    = "TOC-1284"
  }
}

