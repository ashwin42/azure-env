terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  management_group_name = "Managed"
  management_group_policy_assignment = [
    {
      name                 = "tagging_strategy_cc"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: cost-center enforcement"
      description          = "Denies the creation of resources not tagged with cost-center"
      enforce              = true
      parameters           = file("parameter_cost_center.json")
      non_compliance_message = [
        {
          content = "Please define tag: cost-center",
        },
      ]
    },
    {
      name                 = "tagging_strategy_bu"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: business-unit enforcement"
      description          = "Denies the creation of resources not tagged with business-unit"
      enforce              = true
      parameters           = file("parameter_business-unit.json")
      non_compliance_message = [
        {
          content = "Please define tag: business-unit",
        },
      ]
    },
    {
      name                 = "tagging_strategy_dep"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: department enforcement"
      description          = "Denies the creation of resources not tagged with department"
      enforce              = true
      parameters           = file("parameter_department.json")
      non_compliance_message = [
        {
          content = "Please define tag: business-unit",
        },
      ]
    },
  ]
}

