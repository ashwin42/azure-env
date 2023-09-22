locals {
  location               = basename(get_parent_terragrunt_dir())
  secrets_key_vault_rg   = "erp-prod-rg"
  secrets_key_vault_name = "erp-prod-rg"
}
