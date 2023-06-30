terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}//tf-mod-azure/resource_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name = include.root.inputs.resource_group_name
  lock_resources      = false
  iam_assignments = {
    "Contributor" = {
      "groups" = [
        "Integration Enablement Team"
      ]
    }
  }
}

