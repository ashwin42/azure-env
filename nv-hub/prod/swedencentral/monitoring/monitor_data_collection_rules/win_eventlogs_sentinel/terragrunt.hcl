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
  description = "Data Collection Rule for Windows Event Logs. Collects Audit Failed Windows Event logs and sends them to Sentinel  - Managed by Terraform"
  location    = "northeurope"
  windows_event_log = [
    {
      x_path_queries = [
        "Application!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=0)]]",
        "Security!*[System[(band(Keywords,13510798882111488))]]",
        "System!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=0)]]",
      ]
    }
  ]

  log_analytics = [
    {
      workspace_resource_id = "/subscriptions/32de2a14-563c-4f79-a65e-7679f9c6b1b2/resourceGroups/Sentinel/providers/Microsoft.OperationalInsights/workspaces/SentinelasSIEM"
    }
  ]
}

