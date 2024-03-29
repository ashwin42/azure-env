terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//keyvault?ref=v0.10.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//keyvault"
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
  resource_group_name             = "nv-infra-core"
  enabled_for_disk_encryption     = true
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_template_deployment = true
  monitor_diagnostic_settings = [
    {
      name = "nv-infra-core-ds"

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
            days    = 180
            enabled = true
          }
        }
      ]

      metric = [
        {
          category = "AllMetrics"
          enabled  = false

          retention_policy = {
            days    = 0
            enabled = false
          },
        }
      ]
    },
  ]

  iam_assignments = {
    "Key Vault Secrets Officer" = {
      groups = [
        "NV TechOps Consultants Member",
        "NV TechOps Role"
      ],
      service_principals = [
        "atlantis-identity",
      ],
    },
    "Key Vault Administrator" = {
      service_principals = [
        "Backup Management Service",
      ],
    }
  }

  logs = [
    {
      logs_category_group           = "allLogs"
      logs_enabled                  = false
      logs_retention_policy_enabled = false
      logs_retention_policy_days    = 0
    },
    {
      logs_category_group           = "audit"
      logs_enabled                  = true
      logs_retention_policy_enabled = true
      logs_retention_policy_days    = 180
    }
  ]

  metrics = [
    {
      metrics_category                 = "AllMetrics"
      metrics_enabled                  = false
      metrics_retention_policy_enabled = false
      metrics_retention_policy_days    = 0
    },
  ]
}
