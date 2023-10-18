terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//automation?ref=v0.8.7"
  # source = "${dirname(get_repo_root())}/tf-mod-azure/automation"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name = include.root.locals.all_vars.automation_account_name
  automation_runbooks = [
    {
      name         = "PatchingDrainSchedule"
      description  = "Drain a node from AVD"
      runbook_type = "PowerShell"
      log_progress = true
      log_verbose  = false
      content = templatefile("./runbook.ps1", {
        subscription_id = include.root.locals.all_vars.subscription_id
      })
    }
  ]
}

