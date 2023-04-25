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
      ],
      groups = [
        "NV TechOps Role",
        "Azure Tenant Contributor Access",
      ],
    },
    "Log Analytics Contributor" = {
      user_assigned_identities = [
        {
          name                = "log_analytics_policy",
          resource_group_name = "techops-rg"
        }
      ],
    },
    "Owner" = {
      groups = [
        "NV TechOps Lead Role",
        "Azure Tenant Owner Access",
      ],
    },
    "Reader" = {
      groups = [
        "NV TechOps Read Member",
        "NV TechOps Role",
        "NV Aviatrix Admin",
      ],
    },
    "Resource Policy Contributor" = {
      groups = [
        "NV TechOps Role",
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
    },
  }
}

