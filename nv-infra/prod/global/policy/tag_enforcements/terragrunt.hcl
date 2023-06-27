terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  management_group_name = "NV Root"
  management_group_policy_assignment = [
    {
      name                 = "tagging_strategy_cc"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: cost-center"
      description          = "Audits the use tag cost-center or denies creating resources not tagged with cost-center"
      enforce              = false
      parameters           = file("parameter_cost_center.json")
      non_compliance_message = [
        {
          content = "Please add tag: cost-center",
        },
      ]
    },
    {
      name                 = "tagging_strategy_bu"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: business-unit"
      description          = "Audits the use tag business-unit or denies creating resources not tagged with business-unit"
      enforce              = false
      parameters           = file("parameter_business-unit.json")
      non_compliance_message = [
        {
          content = "Please add tag: business-unit",
        },
      ]
    },
    {
      name                 = "tagging_strategy_dep"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: department"
      description          = "Audits the use tag department or denies creating resources not tagged with department"
      enforce              = false
      parameters           = file("parameter_department.json")
      non_compliance_message = [
        {
          content = "Please add tag: department",
        },
      ]
    },
    {
      name                 = "tagging_strategy_project"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: project"
      description          = "Audits the use of tag project"
      enforce              = false
      parameters           = file("parameter_project.json")
      non_compliance_message = [
        {
          content = "Please add tag: project",
        },
      ]
    },
    {
      name                 = "tagging_strategy_gpo"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: global-process-owner"
      description          = "Audits the use of tag global-process-owner"
      enforce              = false
      parameters           = file("parameter_global-process-owner.json")
      non_compliance_message = [
        {
          content = "Please add tag: global-process-owner",
        },
      ]
    },
    {
      name                 = "tagging_strategy_do"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: data-owner"
      description          = "Audits the use of tag data-owner"
      enforce              = false
      parameters           = file("parameter_data-owner.json")
      non_compliance_message = [
        {
          content = "Please add tag: data-owner",
        },
      ]
    },
    {
      name                 = "tagging_strategy_io"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: infrastructure-owner"
      description          = "Audits the use of tag infrastructure-owner"
      enforce              = false
      parameters           = file("parameter_infrastructure-owner.json")
      non_compliance_message = [
        {
          content = "Please add tag: infrastructure-owner",
        },
      ]
    },
    {
      name                 = "tagging_strategy_so"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: system-owner"
      description          = "Audits the use of tag system-owner"
      enforce              = false
      parameters           = file("parameter_system-owner.json")
      non_compliance_message = [
        {
          content = "Please add tag: infrastructure-owner",
        },
      ]
    },
    {
      name                 = "tagging_strategy_rto"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name         = "Tagging Strategy: recovery-time-objective"
      description          = "Audits the use of tag recovery-time-objective"
      enforce              = false
      parameters           = file("parameter_recovery-time-objective.json")
      non_compliance_message = [
        {
          content = "Please add tag: recovery-time-objective",
        },
      ]
    },
  ]
}

