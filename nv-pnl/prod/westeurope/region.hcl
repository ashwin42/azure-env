locals {
  location                  = basename(get_parent_terragrunt_dir())
  secrets_key_vault_name    = "nv-pnl-we-secrets"
  encryption_key_vault_name = "nv-pnl-we-encryption"
  tags = {
    region = basename(get_parent_terragrunt_dir())
  }
}

