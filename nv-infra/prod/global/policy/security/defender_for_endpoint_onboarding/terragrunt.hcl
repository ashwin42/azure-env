terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.55"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group_policy_assignments = [
    {
      name                          = "DefenderOnboarding"
      display_name                  = "Security: Deploy Microsoft Defender for Endpoint agent"
      description                   = "Deploy Microsoft Defender for Endpoint agent on applicable images"
      location                      = "swedencentral"
      management_group_display_name = "NV Root"
      policy_definition_id          = "/providers/Microsoft.Authorization/policySetDefinitions/e20d08c5-6d64-656d-6465-ce9e37fd0ebc"
      identity = {
        type = "SystemAssigned"
      }
    },
  ]
}

