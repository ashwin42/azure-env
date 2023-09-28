terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.26"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group = "Self Managed"
  iam_assignments = {
    "Contributor" = {
      service_principals = [
        "aviatrix_controller_app_prod",
      ],
    },

    "User Access Administrator" = {
      service_principals = [
        "MS-PIM",
      ],
    },
  },

  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109033 Business Systems"
    cost-center   = "109033054 ERP & Microsoft"
  }
}

