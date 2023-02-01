terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group = "Self Managed"
  iam_assignments = {
    "Billing Reader" = {
      groups = [
        "Azure Subscriptions Billing Reader Access",
        "NV BI Subscription Contributor",
      ],
    },
    "Owner" = {
      users = [
        "it@northvolt.com",
      ],
    },
    "Contributor" = {
      service_principals = [
        "aviatrix_controller_app_prod",
      ],
      groups = [
        "NV BI Subscription Contributor",
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
    "User Access Administrator" = {
      service_principals = [
        "MS-PIM",
      ],
    },
    "Key Vault Certificates Officer" = {
      groups = [
        "NV BI Subscription Contributor",
      ],
    },
    "Key Vault Secrets Officer" = {
      groups = [
        "NV BI Subscription Contributor",
      ],
    },
    "Key Vault Contributor" = {
      users = [
        "c.sanjeet.saluja@northvolt.com",
      ],
    },
    "Key Vault Administrator" = {
      groups = [
        "NV BI Subscription Contributor",
      ],
    },
    "Key Vault Crypto Officer" = {
      groups = [
        "NV BI Subscription Contributor",
      ],
    },
  }
}
