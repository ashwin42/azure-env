terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//keyvault?ref=v0.9.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/keyvault"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = include.root.inputs.secrets_key_vault_name
  resource_group_name = include.root.inputs.default_rg
}

inputs = {
  name                            = local.name
  resource_group_name             = local.resource_group_name
  enable_rbac_authorization       = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  iam_assignments = {
    "Key Vault Secrets Officer" = {
      groups = [
        "NV TechOps Role",
      ],
    },
  }
}

