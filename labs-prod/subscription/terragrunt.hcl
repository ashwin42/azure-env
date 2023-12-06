terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group = "Managed"
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
  }

  tags = {
    owner         = "techops@northvolt.com"
    business-unit = "109 Digitalization IT - AB"
    department    = "Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
  }
}
