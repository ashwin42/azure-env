terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//log_analytics_workspace?ref=v0.5.2"
  #source = "../../../../../../tf-mod-azure/log_analytics_workspace/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix               = "nv-hub-analytics-log"
  name                       = "nv-hub-analytics-log"
  resource_group_name        = "log_analytics-rg"
  location                   = "West Europe"
  sku                        = "PerGB2018"
  retention_in_days          = "30"
  internet_ingestion_enabled = true
  internet_query_enabled     = true
  lock_resource              = true
}

