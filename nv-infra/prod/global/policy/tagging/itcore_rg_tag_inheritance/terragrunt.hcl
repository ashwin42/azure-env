terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.55"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  policy_set_definitions = [
    {
      name         = "it-core-rg-tags"
      display_name = "Tag inheritance for IT-Core-RG"
      mode         = "Indexed"
      policy_type  = "Custom"
      policy_definition_reference = [
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Inherit a tag from the resource group"
          parameter_values               = file("parameter_cost-center.json")
          reference_id                   = "tag-cost-center"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Inherit a tag from the resource group"
          parameter_values               = file("parameter_department.json")
          reference_id                   = "tag-department"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Inherit a tag from the resource group"
          parameter_values               = file("parameter_business-unit.json")
          reference_id                   = "tag-business-unit"
        },
      ]
    }
  ]

  resource_group_policy_assignments = [
    {
      name                   = "it-core-rg-tags"
      display_name           = "Tag inheritance for IT-Core-RG"
      description            = "Tags cost-center, business-unit, department should be inherited from IT-Core-RG"
      enforce                = true
      location               = "swedencentral"
      policy_definition_name = "it-core-rg-tags"
      resource_group_name    = "IT-Core-RG"
      identity = {
        type = "SystemAssigned"
      }
    }
  ]
}

