locals {
  location = basename(get_parent_terragrunt_dir())
  tags = {
    region = basename(get_parent_terragrunt_dir())
  }
  network_watcher_flow_log = {
    name               = "${basename(get_original_terragrunt_dir())}-flowlog"
    storage_account_id = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-infra-core/providers/Microsoft.Storage/storageAccounts/nvinfraflowlogweu"
    retention_policy = {
      days    = 7
      enabled = true
    }
    traffic_analytics = {
      enabled               = true
      interval_in_minutes   = 10
      workspace_id          = "26b98d94-f70a-40f5-9cd6-6326befb8902"
      workspace_region      = "westeurope"
      workspace_resource_id = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-infra-automation/providers/Microsoft.OperationalInsights/workspaces/nv-infra-automation"
    }
  }
}
