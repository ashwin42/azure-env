terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.10.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/resource_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name = "arc-ett-barracks"
  iam_assignments = {
    "Azure Connected Machine Onboarding" = {
      service_principals = [
        "Azure Arc Onboarding",
      ],
    },
    "Azure Arc VMware Private Clouds Onboarding" = {
      service_principals = [
        "Azure Arc Onboarding",
      ],
    },
    "Azure Connected Machine Resource Administrator" = {
      service_principals = [
        "patching_assessments",
      ],
    },
  }
}

