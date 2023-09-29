terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.7.61"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//recovery_vault"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  soft_delete_enabled = false

  iam_assignments = {
    "Reader" = {
      users = ["karel.silha@northvolt.com"]
    },
  },
}

