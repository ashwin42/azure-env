terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//resource_group"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  iam_assignments = {
    "Reader" = {
      users = ["karel.silha@northvolt.com"]
    },
  },
}

