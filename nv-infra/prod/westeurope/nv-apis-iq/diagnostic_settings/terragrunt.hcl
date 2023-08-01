terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_diagnostic_setting?ref=v0.7.61"
  #source = "../../../../../tf-mod-azure//monitor_diagnostic_setting/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                           = "apis-iq-logs",
  target_resource_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/apis-iq-rg/providers/Microsoft.Compute/virtualMachines/apis-iq",
  log_analytics_workspace_id     = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/loganalytics-rg/providers/Microsoft.OperationalInsights/workspaces/log-analytics-ops-ws",
  log_analytics_destination_type = "Dedicated"


  #log is to be superseded by 'enabled_log' and will be removed in version 4.0 of the azurerm provider
  log = [
    {
      category = "Audit"
      enabled  = true
      retention_policy = {
        enabled = true
        days    = 180
      }
    }
  ]
}
