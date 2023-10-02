terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_data_collection_rule?ref=v0.7.7"
  #source = "../../../../../../../tf-mod-azure/monitor_data_collection_rule/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  name                         = local.name
  description                  = "Data Collection Rule for Linux Syslogs. Collects warning, error, critical, alert, emergency for syslog and daemon facilities - Managed by Terraform"
  log_analytics_workspace_name = "log-analytics-ops-ws"
  syslog = [
    {
      name = local.name
    }
  ]
  log_analytics = [{}]
}

