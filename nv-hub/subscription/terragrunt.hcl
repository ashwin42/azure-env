terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  subscription_name = "NV-Hub"
  management_group  = "Managed"
  iam_assignments = {
    "Contributor" = {
      service_principals = [
        "aviatrix_controller_app_prod",
        "aviatrix_controller_app_dev"
      ],
    },
    "Reader" = {
      groups = [
        "Azure Subscriptions Reader Access",
        "AWS Admins",
      ],
      users = [
        "christian@northvolt.com",
      ],
    },
    "User Access Administrator" = {
      service_principals = [
        "MS-PIM",
      ],
    },
    "Network Contributor" = {
      groups = [
        "NV TechOps Consultants Member",
      ],
    },
    "Private DNS Zone Contributor" = {
      groups = [
        "NV TechOps Consultants Member",
      ]
    },
  }
}

