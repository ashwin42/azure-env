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
  name            = "NV-D365-Dev"
  iam_assignments = {
    "Reader" = {
      groups = [
        "Azure Subscriptions Reader Access",
      ],
    },
  }

  resource_provider_registrations = [
    {
      name = "Microsoft.PowerPlatform"
    },
  ]

  tags = {
    business-unit = "109033 Business Systems"
    department    = "109 Digitalization IT - AB"
    cost-center   = "109033054 ERP & Microsoft"
  }
}

