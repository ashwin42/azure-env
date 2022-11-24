terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "rg-int-item-batch-information-tc-uat"
  iam_assignments = {
    "Contributor" = {
      "users" = [
        "c.rahul.bhandari@northvolt.com",
      ],
    },
  }
}