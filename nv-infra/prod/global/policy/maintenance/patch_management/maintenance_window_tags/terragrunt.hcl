terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  policy_set_definitions = [
    {
      name                          = "maintenance_windows_tags"
      display_name                  = "Patching: Maintenance windows based on tags"
      description                   = "Attaches virtual machines to maintenance configurations based on tags"
      management_group_display_name = "NV Root"
      mode                          = "Indexed"
      policy_type                   = "Custom"
      policy_definition_reference = [
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Schedule recurring updates using Update Management Center"
          parameter_values               = file("monday_parameters.json")
          reference_id                   = "maintenance_window_monday"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Schedule recurring updates using Update Management Center"
          parameter_values               = file("tuesday_parameters.json")
          reference_id                   = "maintenance_window_tuesday"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Schedule recurring updates using Update Management Center"
          parameter_values               = file("wednesday_parameters.json")
          reference_id                   = "maintenance_window_wednesday"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Schedule recurring updates using Update Management Center"
          parameter_values               = file("thursday_parameters.json")
          reference_id                   = "maintenance_window_thursday"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Schedule recurring updates using Update Management Center"
          parameter_values               = file("friday_parameters.json")
          reference_id                   = "maintenance_window_friday"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Schedule recurring updates using Update Management Center"
          parameter_values               = file("saturday_parameters.json")
          reference_id                   = "maintenance_window_saturday"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Schedule recurring updates using Update Management Center"
          parameter_values               = file("sunday_parameters.json")
          reference_id                   = "maintenance_window_sunday"
        },
      ]
    }
  ]

  management_group_policy_assignments = [
    {
      name                          = "maintenance_windows_tags"
      display_name                  = "Patching: Reccuring maintenance windows for updates based on tags"
      management_group_display_name = "NV Root"
      policy_definition_name        = "maintenance_windows_tags"
      description                   = "Attaches virtual machines to maintenance configurations based on tags"
      location                      = "swedencentral"
      enforce                       = true
      identity = {
        type = "SystemAssigned"
      }
    },
  ]
}

