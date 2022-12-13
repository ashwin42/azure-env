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
