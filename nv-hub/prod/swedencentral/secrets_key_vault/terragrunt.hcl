terraform {
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                            = include.root.inputs.secrets_key_vault_name
  resource_group_name             = include.root.inputs.secrets_key_vault_rg
  enable_rbac_authorization       = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  purge_protection_enabled        = true
  create_resource_group           = true

}

