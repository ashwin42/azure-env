terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.24"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  iam_assignments = {
    "Owner" = {
      groups = [
        "NV Tools & Products Member",
      ],
    },
  }
}
