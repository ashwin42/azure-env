terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//action_group?ref=v0.7.27"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/action_group/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name     = "techops-rg"
  action_group_name       = "techops_azure_opsgenie"
  action_group_short_name = "techops_og"
  action_group_webhook_receivers = [
    {
      name                    = "techops_opsgenie",
      service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=6e0d86fa-610d-4da1-bf3c-928ba6be473a",
      use_common_alert_schema = true
    }
  ]
}

