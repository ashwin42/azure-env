terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//log_analytics_workspace?ref=v0.7.7"
  #source = "../../../../../../tf-mod-azure/log_analytics_workspace/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                       = "log-analytics-ops-ws"
  sku                        = "PerGB2018"
  retention_in_days          = "180"
  internet_ingestion_enabled = true
  internet_query_enabled     = true
  lock_resource              = true
}

