terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include "root" {
  expose = true
  path   = find_in_parent_folders()
}

inputs = {
  resource_group_name = include.root.locals.all_vars.resource_group_name
  iam_assignments = {
    "Owner" = {
      "users" = [
        "mijael.rodriguez@northvolt.com",
      ],
    },
  }
}