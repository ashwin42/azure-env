terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.24"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  iam_assignments = {
    "Contributor" = {
      "groups" = [
        "NV Tools & Products Member",
      ],
    },
    "Owner" = {
      "users" = [
        "alex.altieri@northvolt.com",
      ],
    },
  }
}

