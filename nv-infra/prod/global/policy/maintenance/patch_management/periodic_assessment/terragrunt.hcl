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
      name                          = "periodic-assessments"
      display_name                  = "Patching: Periodic Assessments"
      description                   = "Enables periodic assessment of OS updates for Windows & Linux VMs for Azure & Azure Arc enabled VMs"
      management_group_display_name = "NV Root"
      mode                          = "Indexed"
      policy_type                   = "Custom"
      policy_definition_reference = [
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Configure periodic checking for missing system updates on azure virtual machines"
          parameter_values               = file("parameters_win.json")
          reference_id                   = "ospatching_win"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Configure periodic checking for missing system updates on azure virtual machines"
          parameter_values               = file("parameters_linux.json")
          reference_id                   = "ospatching_linux"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Configure periodic checking for missing system updates on azure virtual machines"
          parameter_values               = file("parameters_win.json")
          reference_id                   = "ospatching_arc_win"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "[Preview]: Configure periodic checking for missing system updates on azure virtual machines"
          parameter_values               = file("parameters_linux.json")
          reference_id                   = "ospatching_arc_linux"
        },
      ]
    }
  ]

  management_group_policy_assignments = [
    {
      name                          = "patching_assessments"
      display_name                  = "Patching: Periodic Assessments - Managed Subscriptions"
      management_group_display_name = "NV Root"
      policy_definition_name        = "periodic-assessments"
      description                   = "Enforces periodic assessment of Windows & Linux OS updates for Azure & Azure Arc enabled VMs"
      location                      = "swedencentral"
      not_scopes                    = ["/providers/Microsoft.Management/managementGroups/nv_self_managed"]
      enforce                       = true
      identity = {
        type = "SystemAssigned"
      }
    },
  ]
}

