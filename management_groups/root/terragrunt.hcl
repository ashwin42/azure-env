terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//management_group?ref=v0.7.27"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/management_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name         = "706c5db9-5278-483b-b622-70084f823a12"
  display_name = "Tenant Root Group"

  iam_assignments = {
    "Billing Reader" = {
      groups = [
        "Azure Subscriptions Billing Reader Access",
        "NV TechOps Role",
      ],
    },
    "Contributor" = {
      apps = [
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
      apps = [
        "DefenderOnboarding",
      ],
    },
    "Support Request Contributor" = {
      groups = [
        "Azure Subscriptions Support Request Contributor",
      ],
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

