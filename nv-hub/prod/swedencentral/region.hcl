locals {
  location                  = basename(get_parent_terragrunt_dir())
  secrets_key_vault_name    = "vm-secrets-kv"
  secrets_key_vault_rg      = "vm-secrets-kv-rg"
  encryption_key_vault_name = "nv-swc-hub-vm-enc-kv"
  encryption_key_vault_rg   = "nv-swc-hub-vm-enc-kv-rg"
  tags = {
    region = basename(get_parent_terragrunt_dir())
  }
  additional_providers = [
    {
      alias           = "localadmin_keyvault"
      provider        = "azurerm"
      subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      blocks = {
        features = {},
      },
    },
  ]
}
