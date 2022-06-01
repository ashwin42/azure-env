terraform {
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                        = include.root.inputs.encryption_key_vault_name
  resource_group_name         = include.root.inputs.encryption_key_vault_rg
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  create_resource_group       = true

}

