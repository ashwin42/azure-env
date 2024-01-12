terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.10.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group_policy_assignments = [
    {
      name                          = "DefenderForServer"
      display_name                  = "Security: Azure Defender for Server should be enabled"
      description                   = "Enforces subscriptions to enable Defender for Server Plan"
      location                      = "swedencentral"
      management_group_display_name = "NV Root"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/8e86a5b6-b9bd-49d1-8e21-4bb8a0862222"
      identity = {
        type = "SystemAssigned"
      }
    },
  ]
}

