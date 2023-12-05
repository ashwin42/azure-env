terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  policy_set_definitions = [
    {
      name                          = "TaggingStrategy_Audit"
      display_name                  = "Tagging Strategy: Tag Presence Auditing"
      description                   = "Audits the use of tags required by the Azure tagging strategy"
      management_group_display_name = "NV Root"
      mode                          = "Indexed"
      policy_type                   = "Custom"
      policy_definition_reference = [
        {
          reference_id                   = "tagging_strategy_costcenter"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_cost-center.json")
        },
        {
          reference_id                   = "tagging_strategy_businessunit"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_business-unit.json")
        },
        {
          reference_id                   = "tagging_strategy_department"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_department.json")
        },
        {
          reference_id                   = "tagging_strategy_project"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_project.json")
        },
        {
          reference_id                   = "tagging_strategy_gpo"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_global-process-owner.json")
        },
        {
          reference_id                   = "tagging_strategy_dataowner"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_data-owner.json")
        },
        {
          reference_id                   = "tagging_strategy_infraowner"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_infrastructure-owner.json")
        },
        {
          reference_id                   = "tagging_strategy_systemowner"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_system-owner.json")
        },
        {
          reference_id                   = "tagging_strategy_rto"
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Require a tag on resources"
          parameter_values               = file("parameters/parameter_recovery-time-objective.json")
        },
      ]
    }
  ]

  management_group_policy_assignments = [
    {
      name                          = "TaggingStrategy_Audit"
      display_name                  = "Tagging Strategy: Tag Presence Auditing"
      management_group_display_name = "NV Root"
      policy_definition_name        = "TaggingStrategy_Audit"
      description                   = "Audits the use of tags required by the Azure tagging strategy of resources in the NV Root management group"
      location                      = "swedencentral"
      enforce                       = false
    },
  ]

  management_group_policy_exemptions = [
    {
      name                   = "selfmanaged_tag_audit_exemption"
      description            = "Exempts the auditing of required Azure tags for nv_self_managed management group"
      display_name           = "Tagging Strategy Exemption: Self Managed Subscriptions"
      management_group_name  = "nv_self_managed"
      policy_assignment_name = "TaggingStrategy_Audit"
      exemption_category     = "Waiver"
    },
  ]
}
