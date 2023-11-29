terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//resource_group"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  iam_assignments = {
    "Owner" = {
      groups = [
        "NV IT Core Seniors",
      ],
    },
    "Contributor" = {
      groups = [
        "NV IT Core Azure Resource",
      ],
    },
    "Key Vault Administrator" = {
      groups = [
        "NV IT Core Seniors",
      ],
    },
    "Reader" = {
      groups = [
        "NV IAM Architect Member",
      ],
    },
  }
}

