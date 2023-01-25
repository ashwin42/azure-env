terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//action_rule?ref=v0.7.27"
  #source = "${dirname(get_repo_root())}//tf-mod-azure/action_rule/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                 = "azure_backup_fails_nv-dwa"
  resource_group_name  = "monitoring-ops"
  action_group_id      = "/subscriptions/11DD160F-0E01-4B4D-A7A0-59407E357777/resourceGroups/monitoring-ops/providers/microsoft.insights/actionGroups/techops_azure_opsgenie"

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

