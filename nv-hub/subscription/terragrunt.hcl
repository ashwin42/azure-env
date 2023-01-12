terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.26"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  subscription_name = "NV-Hub"
  management_group  = "Tenant Root Group"
  iam_assignments = {
    "Billing Reader" = {
      groups = [
        "Azure Subscriptions Billing Reader Access",
      ],
    },
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
    "Support Request Contributor" = {
      groups = [
        "Azure Subscriptions Support Request Contributor",
      ],
    },
    "Log Analytics Reader" = {
      service_principals = [
        "Grafana Dev - Azure Monitor Datasource",
      ],
    },
    "Monitoring Reader" = {
      service_principals = [
        "Grafana Dev - Azure Monitor Datasource",
      ],
    },
    "User Access Administrator" = {
      service_principals = [
        "MS-PIM",
      ],
    },
    "Lucidchart Cloud Insights import" = {
      service_principals = [
        "LucidChart Cloud Insights Access"
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

