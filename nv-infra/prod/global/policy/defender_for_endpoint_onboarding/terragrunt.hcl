terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.22"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  management_group_policy_assignment = [
    {
      name                 = "DefenderOnboarding"
      location             = "swedencentral"
      management_group_id  = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/e20d08c5-6d64-656d-6465-ce9e37fd0ebc"
      description          = "Deploy Microsoft Defender for Endpoint agent on applicable images"
      display_name         = "Deploy Microsoft Defender for Endpoint agent"

      identity = [
        {
          type = "SystemAssigned"
        },
      ]
    },
  ]
}

