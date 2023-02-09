terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//action_rule?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}//tf-mod-azure/action_rule/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                 = "azure_backup_fails"
  resource_group_name  = "monitoring-ops"
  action_group_rg_name = "monitoring-ops"
  action_group_name    = "techops_azure_opsgenie"

  condition = {
    monitor_service = {
      operator = "Equals",
      values   = ["Azure Backup"],
    }
    severity = {
      operator = "Equals",
      values = [
        "Sev0",
        "Sev1",
      ],
    }
  }
}

