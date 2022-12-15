terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.20"
  #source = "${dirname(get_repo_root())}/subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  subscription_name = "NV_Gen_Infra"
  iam_assignments = {
    "Billing Reader" = {
      groups = [
        "Azure Subscriptions Billing Reader Access",
      ],
    },
    "Contributor" = {
      service_principals = [
        "aviatrix_controller_app_prod",
        "MoveCollection-ne-we-ne",
        "nv_infra_packer",
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
    "Monitoring Reader" = {
      service_principals = [
        "Grafana Dev - Azure Monitor Datasource",
      ],
    },
    "User Access Administrator" = {
      service_principals = [
        "MS-PIM",
        "MoveCollection-ne-we-ne",
      ],
    },
    "Lucidchart Cloud Insights import" = {
      service_principals = [
        "LucidChart Cloud Insights Access"
      ]
    }
  }
}