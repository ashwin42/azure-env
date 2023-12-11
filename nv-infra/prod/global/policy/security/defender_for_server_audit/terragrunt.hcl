terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group_policy_assignments = [
    {
      name                          = "DefenderForServer_Audit"
      display_name                  = "Security: Azure Defender for server should be enabled"
      description                   = "Audits defender for server coverage"
      location                      = "swedencentral"
      management_group_display_name = "NV Root"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/4da35fc9-c9e7-4960-aec9-797fe7d9051d"
    },
  ]
}

