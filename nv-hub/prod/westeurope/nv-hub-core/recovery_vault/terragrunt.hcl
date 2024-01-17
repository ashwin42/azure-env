terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.10.5"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//recovery_vault/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  recovery_vault_name = "nv-hub-we-rv"

  backup_policies_vm = [
    {
      name = "DefaultPolicy"
      backup = {
        frequency = "Daily"
        time      = "19:30"
      }
      retention_daily = {
        count = 30
      }
    },
    {
      name        = "EnhancedPolicy"
      policy_type = "V2"
      backup = {
        frequency     = "Hourly"
        time          = "08:00"
        hour_duration = 12
        hour_interval = 4
      }
      retention_daily = {
        count = 30
      }
    },
  ]

  backup_policies_vm_workload = [
    {
      name          = "HourlyLogBackup"
      workload_type = "SQLDataBase"
      protection_policy = [
        {
          policy_type = "Full"
          backup = {
            frequency = "Daily"
            time      = "19:30"
          }
          retention_daily = {
            count = 30
          }
        },
        {
          policy_type = "Log"
          backup = {
            frequency_in_minutes = 60
          }
          simple_retention = {
            count = 30
          }
        },
      ]

      settings = {
        time_zone           = "UTC"
        compression_enabled = false
      }
    },
  ]
}

