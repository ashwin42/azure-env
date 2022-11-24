terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.15"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "D365-DBBackup"
  setup_prefix        = ""
  iam_assignments = {
    "Contributor" = {
      "users" = [
        "sa-d365deployett@northvolt.com",
      ],
    },
  }
}