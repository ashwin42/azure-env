locals {
  location                  = basename(get_parent_terragrunt_dir())
  secrets_key_vault_name    = "vm-secrets-kv"
  secrets_key_vault_rg      = "vm-secrets-kv-rg"
  encryption_key_vault_name = "nv-swc-hub-vm-enc-kv"
  encryption_key_vault_rg   = "nv-swc-hub-vm-enc-kv-rg"
  tags = {
    region = "swedencentral"
  }
}
