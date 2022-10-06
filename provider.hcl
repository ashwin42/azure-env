locals {
  loganalytics_subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5" 
  loganalytics_resource_group_name = "log_analytics-rg"
  windows_data_collection_rule_names = [
    "win_eventlogs_sentinel-datacollectionrule"
  ]
  linux_data_collection_rule_names = [
    "linux_syslog-datacollectionrule"
  ]
}