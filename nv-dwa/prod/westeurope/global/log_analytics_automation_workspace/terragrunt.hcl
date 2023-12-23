terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//log_analytics_workspace?ref=v0.10.2"
  # source = "${dirname(get_repo_root())}/tf-mod-azure//log_analytics_workspace/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                       = "${include.root.locals.all_vars.subscription_name}-automation"
  sku                        = "PerGB2018"
  retention_in_days          = "180"
  internet_ingestion_enabled = true
  internet_query_enabled     = true
  enable_updates_solution    = true

  linked_automation_account = {
    labs-automation = {
      automation_account_name = include.root.locals.all_vars.automation_account_name
      automation_account_rg   = include.root.locals.all_vars.automation_account_rg
    }
  }
}

