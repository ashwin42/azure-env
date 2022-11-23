terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.15"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "TalentIntegration"
  setup_prefix        = ""
  iam_assignments = {
    "Contributor" = {
      "users" = [
        "c.rahul.bhandari@northvolt.com",
        "switee.patel@northvolt.com",
      ],
    },
    "Logic App Contributor" = {
      "users" = [
        "vladimir.kosilko@northvolt.com",
      ],
    },
  }
}