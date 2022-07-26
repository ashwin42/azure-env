terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_data_collection_rule?ref=v0.5.1"
  source = "../../../../../../../tf-mod-azure/monitor_data_collection_rule/"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  name        = local.name
  description = "Data Collection Rule for Windows Event Logs. Collects warning, error, critical for Application and System logs, as well as Service Control Manager entries  - Managed by Terraform"
  windows_event_log = [
    {
      name = local.name
    }
  ]
  log_analytics = [{}]
}

