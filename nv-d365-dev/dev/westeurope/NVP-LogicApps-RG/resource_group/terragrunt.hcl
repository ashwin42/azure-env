terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  iam_assignments = {
    "Owner" = {
      "groups" = [
        "NVP LogicApp Administrators",
      ],
    },
    "Logic App Operator" = {
      "groups" = [
        "NVP LogicApp Administrators",
      ],
    },
    "Logic App Contributor" = {
      "groups" = [
        "NVP LogicApp Administrators",
      ],
      "users" = [
        "wojciech.bloch@northvolt.com",
      ],
    },
  }
}
