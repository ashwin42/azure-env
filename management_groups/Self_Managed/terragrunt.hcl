terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//management_group?ref=v0.7.46"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/management_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                    = "nv_self_managed"
  display_name            = "Self Managed"
  parent_management_group = "Northvolt AB"

  iam_assignments = {
    "Management Group Reader" = {
      groups = [
        "Azure Self Managed Management Group Reader",
      ],
    },
  }
}

