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
  description                  = "Data Collection Rule for Windows Event Logs. Collects Service Control Manager entries  - Managed by Terraform"
  log_analytics_workspace_name = "log-analytics-ops-ws"
  windows_event_log = [
    {
      name           = local.name
      x_path_queries = ["System!*[System[Provider[@Name='Service Control Manager']]]"]
    }
  ]
  log_analytics = [{}]
}

