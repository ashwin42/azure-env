terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  policy_set_definitions = [
    {
      name                          = "AMAOnboarding"
      display_name                  = "Monitoring: Azure Monitoring Agent Onboarding"
      description                   = "Will deploy the Azure Monitoring Agent to all VMs and associate them with the Sentinel Log Analytics Workspace"
      management_group_display_name = "NV Root"
      mode                          = "Indexed"
      policy_type                   = "Custom"
      policy_definition_reference = [
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Configure Linux virtual machines to run Azure Monitor Agent with user-assigned managed identity-based authentication"
          parameter_values               = file("parameters/parameters_ama-linux.json")
          reference_id                   = "ama_linux"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Deploy Dependency agent for Linux virtual machines with Azure Monitoring Agent settings"
          reference_id                   = "ama_dependency_linux"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Configure Linux Machines to be associated with a Data Collection Rule or a Data Collection Endpoint"
          parameter_values               = file("parameters/parameters_ama-conf-linux.json")
          reference_id                   = "ama_conf_linux"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Configure Windows virtual machines to run Azure Monitor Agent with user-assigned managed identity-based authentication"
          parameter_values               = file("parameters/parameters_ama-windows.json")
          reference_id                   = "ama_windows"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Deploy Dependency agent to be enabled on Windows virtual machines with Azure Monitoring Agent settings"
          reference_id                   = "ama_dependency_windows"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Configure Windows Machines to be associated with a Data Collection Rule or a Data Collection Endpoint"
          parameter_values               = file("parameters/parameters_ama-conf-windows.json")
          reference_id                   = "ama_conf_windows"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Configure Windows Arc-enabled machines to run Azure Monitor Agent"
          reference_id                   = "ama_arc_windows"
        },
        {
          fetch_policy_definition_id     = true
          policy_definition_display_name = "Configure Linux Arc-enabled machines to run Azure Monitor Agent"
          reference_id                   = "ama_arc_linux"
        },
      ]
    }
  ]

  management_group_policy_assignments = [
    {
      name                          = "AMAOnboarding"
      display_name                  = "Monitoring: Azure Monitoring Agent Onboarding"
      management_group_display_name = "NV Root"
      policy_definition_name        = "AMAOnboarding"
      description                   = "Deploys the Azure Monitoring Agent to all VMs and associate them with the Sentinel Log Analytics Workspace"
      location                      = "swedencentral"
      enforce                       = true
      identity = {
        type = "SystemAssigned"
      }
    },
  ]
}
