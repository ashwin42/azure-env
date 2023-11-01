terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_policy_assignments = [
    {
      name                 = "it-core-location"
      display_name         = "Allowed location for resources in IT-Core-RG"
      description          = "Restricts the creation of resources in IT-Core-RG to specific locations"
      enforce              = true
      location             = "swedencentral"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
      resource_group_name  = "IT-Core-RG"
      parameters           = file("parameters_location.json")
      non_compliance_message = [
        {
          content = "Please use region Sweden Central",
        },
      ]
    }
  ]
}

