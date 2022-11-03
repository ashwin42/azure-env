locals {
  location                  = basename(get_parent_terragrunt_dir())
  secrets_key_vault_name    = "nv-prod-swe-secrets"
  encryption_key_vault_name = "nv-prod-swe-encryption"
}

