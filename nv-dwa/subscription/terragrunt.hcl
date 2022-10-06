terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.6.10"
  #source = "../../../tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  iam_assignments = {
    "Billing Reader" = {
      groups = [
        "Azure Subscriptions Billing Reader Access",
      ],
    },
    "Contributor" = {
      service_principals = [
        "aviatrix_controller_app_prod",
      ],
    },
    "Reader" = {
      groups = [
        "Azure Subscriptions Reader Access",
      ],
    },
    "Support Request Contributor" = {
      groups = [
        "Azure Subscriptions Support Request Contributor",
      ],
    },
  }
}
