terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.15"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "NVP-LogicApps-RG"
  setup_prefix        = ""
  iam_assignments = {
    "Owner" = {
      "groups" = [
        "NVP LogicApp Administrators",
      ],
    },
    "Logic App Contributor" = {
      "groups" = [
        "NVP LogicApp Administrators",
      ],
    },
    "Logic App Operator" = {
      "groups" = [
        "NVP LogicApp Administrators",
      ],
    },
  }
}