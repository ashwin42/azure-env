terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "AzureAPImanagment"
  iam_assignments = {
    "Contributor" = {
      "users" = [
        "switee.patel@northvolt.com",
      ],
    },
    "Owner" = {
      "users" = [
        "c.sanjeet.saluja@northvolt.com",
      ],
    },
  }
}