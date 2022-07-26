terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_data_collection_rule?ref=v0.5.1"
  #source = "../../../../../../../tf-mod-azure/monitor_data_collection_rule/"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  name        = "win_eventlogs_sentinel"
  description = "Data Collection Rule for Windows Event Logs. Collects Audit Failed Windows Event logs and sends them to Sentinel  - Managed by Terraform"
  location    = "northeurope"
  windows_event_log = [
    {
      x_path_queries = ["Security!*[System[(band(Keywords,4503599627370496))]]"]
    }
  ]

  log_analytics = [
    {
      workspace_resource_id = "/subscriptions/32de2a14-563c-4f79-a65e-7679f9c6b1b2/resourceGroups/Sentinel/providers/Microsoft.OperationalInsights/workspaces/SentinelasSIEM"
    }
  ]
}

