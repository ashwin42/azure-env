terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.20"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group = "Tenant Root Group"
  iam_assignments = {
    "Owner" = {
      groups = [
        "Azure Tenant Owner Access",
      ],
    },
  }
}
