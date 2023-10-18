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
      name                          = "tagging_strategy_cc"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: cost-center"
      description                   = "Audits the use of tag: cost-center"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_cost_center.json")
      non_compliance_message = [
        {
          content = "Please add tag: cost-center",
        },
      ]
    },
    {
      name                          = "tagging_strategy_bu"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: business-unit"
      description                   = "Audits the use of tag: business-unit"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_business-unit.json")
      non_compliance_message = [
        {
          content = "Please add tag: business-unit",
        },
      ]
    },
    {
      name                          = "tagging_strategy_dep"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: department"
      description                   = "Audits the use of tag: department"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_department.json")
      non_compliance_message = [
        {
          content = "Please add tag: department",
        },
      ]
    },
    {
      name                          = "tagging_strategy_project"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: project"
      description                   = "Audits the use of tag: project"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_project.json")
      non_compliance_message = [
        {
          content = "Please add tag: project",
        },
      ]
    },
    {
      name                          = "tagging_strategy_gpo"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: global-process-owner"
      description                   = "Audits the use of tag: global-process-owner"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_global-process-owner.json")
      non_compliance_message = [
        {
          content = "Please add tag: global-process-owner",
        },
      ]
    },
    {
      name                          = "tagging_strategy_do"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: data-owner"
      description                   = "Audits the use of tag: data-owner"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_data-owner.json")
      non_compliance_message = [
        {
          content = "Please add tag: data-owner",
        },
      ]
    },
    {
      name                          = "tagging_strategy_io"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: infrastructure-owner"
      description                   = "Audits the use of tag: infrastructure-owner"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_infrastructure-owner.json")
      non_compliance_message = [
        {
          content = "Please add tag: infrastructure-owner",
        },
      ]
    },
    {
      name                          = "tagging_strategy_so"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: system-owner"
      description                   = "Audits the use of tag: system-owner"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_system-owner.json")
      non_compliance_message = [
        {
          content = "Please add tag: infrastructure-owner",
        },
      ]
    },
    {
      name                          = "tagging_strategy_rto"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
      display_name                  = "Tagging Strategy: recovery-time-objective"
      description                   = "Audits the use of tag: recovery-time-objective"
      management_group_display_name = "NV Root"
      enforce                       = false
      parameters                    = file("parameter_recovery-time-objective.json")
      non_compliance_message = [
        {
          content = "Please add tag: recovery-time-objective",
        },
      ]
    },
  ]

  management_group_policy_exemptions = [
    {
      name                   = "selfmanaged_tag_project"
      description            = "Exempts the audit of tag project for nv_self_managed management group"
      display_name           = "Tagging Strategy Exemption: project"
      management_group_name  = "nv_self_managed"
      policy_assignment_name = "tagging_strategy_project"
      exemption_category     = "Waiver"
    },
    {
      name                   = "selfmanaged_tag_gpo"
      description            = "Exempts the audit of tag global-process-owner for nv_self_managed management group"
      display_name           = "Tagging Strategy Exemption: global-process-owner"
      management_group_name  = "nv_self_managed"
      policy_assignment_name = "tagging_strategy_gpo"
      exemption_category     = "Waiver"
    },
    {
      name                   = "selfmanaged_tag_do"
      description            = "Exempts the audit of tag data-owner for nv_self_managed management group"
      display_name           = "Tagging Strategy Exemption: data-owner"
      management_group_name  = "nv_self_managed"
      policy_assignment_name = "tagging_strategy_do"
      exemption_category     = "Waiver"
    },
    {
      name                   = "selfmanaged_tag_io"
      description            = "Exempts the audit of tag infrastructure-owner for nv_self_managed management group"
      display_name           = "Tagging Strategy Exemption: infrastructure-owner"
      management_group_name  = "nv_self_managed"
      policy_assignment_name = "tagging_strategy_io"
      exemption_category     = "Waiver"
    },
    {
      name                   = "selfmanaged_tag_so"
      description            = "Exempts the audit of tag system-owner for nv_self_managed management group"
      display_name           = "Tagging Strategy Exemption: system-owner"
      management_group_name  = "nv_self_managed"
      policy_assignment_name = "tagging_strategy_so"
      exemption_category     = "Waiver"
    },
    {
      name                   = "selfmanaged_tag_rto"
      description            = "Exempts the audit of tag recovery-time-objective for nv_self_managed management group"
      display_name           = "Tagging Strategy Exemption: recovery-time-objective"
      management_group_name  = "nv_self_managed"
      policy_assignment_name = "tagging_strategy_rto"
      exemption_category     = "Waiver"
    },
  ]
}

