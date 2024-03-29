terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//management_group?ref=v0.7.46"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/management_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                    = "nv_root"
  display_name            = "NV Root"
  parent_management_group = "Tenant Root Group"
  iam_assignments = {
    "Billing Reader" = {
      groups = [
        "Azure Subscriptions Billing Reader Access",
        "NV TechOps Role",
      ],
    },
    "Contributor" = {
      service_principals = [
        "DefenderOnboarding",
        "maintenance_windows_tags",
        "AMAOnboarding",
      ],
    },
    "Owner" = {
      groups = [
        "NV TechOps Lead Role",
      ],
    },
    "Reader" = {
      groups = [
        "Azure Subscriptions Reader Access",
        "NV TechOps Read Member",
        "NV Aviatrix Admin",
        "NV Cyber Defence Member",
        "NV IT Service Support Member"
      ],
    },
    "Resource Policy Contributor" = {
      groups = [
        "NV TechOps Role",
      ],
    },
    "Security Admin" = {
      service_principals = [
        "DefenderForCloud",
        "DefenderForServer"
      ],
    },
    "Security Reader" = {
      service_principals = [
        "DefenderOnboarding",
      ],
    },
    "Support Request Contributor" = {
      groups = [
        "Azure Subscriptions Support Request Contributor",
      ],
    },
    "Log Analytics Reader" = {
      service_principals = [
        "Grafana - Azure Monitor Datasource",
      ],
    },
    "Monitoring Reader" = {
      service_principals = [
        "Grafana - Azure Monitor Datasource",
      ],
    },
    "Network Reader" = {
      groups = [
        "NV Network Member",
      ]
    },
    "Network Contributor" = {
      groups = [
        "NV Aviatrix Admin",
      ],
    },
    "Virtual Machine Contributor" = {
      groups = [
        "NV Aviatrix Admin",
      ],
      service_principals = [
        "patching_assessments",
      ]
    },
    "Terraform Resource Groups Contributor" = {
      service_principals = [
        "atlantis-identity",
      ],
    }
  }
}
