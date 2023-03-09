locals {
  resource_group_name = "${basename(get_terragrunt_dir())}-rg"
  recovery_vault_name = "${basename(get_terragrunt_dir())}-rv"
}

