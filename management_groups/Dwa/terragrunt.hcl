terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//management_group?ref=v0.7.51"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/management_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                    = "Dwa"
  display_name            = "Dwa"
  parent_management_group = "NV Root"
  iam_assignments = {
    "Reader" = {
      service_principals = ["Promitor Azure Monitor Scraper"]
    },
  }
}

