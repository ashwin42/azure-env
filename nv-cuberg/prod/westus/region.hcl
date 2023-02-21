locals {
  location = basename(get_parent_terragrunt_dir())
  secrets_key_vault_name    = "nv-cuberg-infra-we-secrets"
  encryption_key_vault_name = "nv-cuberg-infra-we-encryption"
  tags = {
    region = basename(get_parent_terragrunt_dir())
  }
}

