locals {
  location = basename(get_parent_terragrunt_dir())
  secrets_key_vault_name    = "nv-dwa-infra-we-secrets"
  encryption_key_vault_name = "nv-dwa-infra-we-encryption"
  tags = {
    region = "westeurope"
  }
}

