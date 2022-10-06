terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//keyvault?ref=v0.6.10"
  #source = "../../../../../../tf-mod-azure/keyvault//"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = include.root.inputs.secrets_key_vault_name
}

inputs = {
  name                            = "nvdwainfrasecrets"
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
