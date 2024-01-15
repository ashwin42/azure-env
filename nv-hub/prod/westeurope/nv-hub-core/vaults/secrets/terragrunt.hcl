terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//keyvault?ref=v0.10.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//keyvault/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = include.root.inputs.secrets_key_vault_name
}

inputs = {
  name                            = local.name
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_template_deployment = false

  iam_assignments = {
    "Key Vault Administrator" = {
      groups = [
        "NV TechOps Role",
        "AWS Admins",
      ],
    },
    "Key Vault Secrets Officer" = {
      groups = [
        "NV TechOps Role",
      ],
    },
  }

  monitor_diagnostic_settings = [
    {
      name = "nv-hub-core-we-ds"

      log = [
        {
          category_group = "allLogs"
          enabled        = false

          retention_policy = {
            days    = 0
            enabled = false
          }
        },
        {
          category_group = "audit"
          enabled        = true

          retention_policy = {
            days    = 0
            enabled = false
          }
        },
      ]

      metric = [
        {
          category = "AllMetrics"
          enabled  = false

          retention_policy = {
            days    = 0
            enabled = false
          }
        },
      ]
    },
  ]
}

