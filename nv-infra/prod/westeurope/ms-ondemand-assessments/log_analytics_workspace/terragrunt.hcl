terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//log_analytics_workspace?ref=v0.7.53"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/log_analytics_workspace/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                       = "ms-oda-log-analytics-ws"
  sku                        = "PerGB2018"
  internet_ingestion_enabled = true
  internet_query_enabled     = true
  lock_resource              = true

  iam_assignments = {
    "Log Analytics Reader" = {
      groups = [
        "NV IT Core Member",
        "NV Cyber Defence Member",
      ],
    },
  }
}

