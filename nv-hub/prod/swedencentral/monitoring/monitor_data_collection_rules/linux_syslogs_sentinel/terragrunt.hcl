terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_data_collection_rule?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/monitor_data_collection_rule/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  name        = local.name
  description = "Data Collection Rule for Linux Syslogs. Collects and sends them to Sentinel  - Managed by Terraform"
  location    = "northeurope"
  syslog = [
    {
      facility_names = [
        "auth",
        "authpriv",
        "cron",
        "daemon",
        "kern",
        "local0",
        "local1",
        "local2",
        "local3",
        "local4",
        "local5",
        "local6",
        "local7",
        "lpr",
        "mail",
        "mark",
        "news",
        "syslog",
        "user",
        "uucp",
      ]
      log_levels = [
        "Info",
        "Notice",
        "Warning",
        "Error",
        "Critical",
        "Alert",
        "Emergency",
      ]
    }
  ]


  log_analytics = [
    {
      workspace_resource_id = "/subscriptions/32de2a14-563c-4f79-a65e-7679f9c6b1b2/resourceGroups/Sentinel/providers/Microsoft.OperationalInsights/workspaces/SentinelasSIEM"
    }
  ]
}
