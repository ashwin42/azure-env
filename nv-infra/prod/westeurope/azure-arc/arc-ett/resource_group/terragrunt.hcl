terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.8.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/resource_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
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

