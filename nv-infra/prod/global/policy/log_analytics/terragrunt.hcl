terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.4.0"
  #source = "../../../../../../tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  management_group_name  = "Tenant Root Group"
  service_principal_name = "log_analytics_policy"
  role_definition_name   = "Log Analytics Contributor"

  #Policy Set (Initiative)
  policy_set_name         = "log_analytics_initiative"
  policy_set_display_name = "Log Analytics for VMs Initiative"
  policy_set_description  = "Enables VMs to ship logs to the SentinelasSIEM Log Analytics Workspace"
  policy_set_metadata     = file("category_monitoring.json")
  policy_definition_reference = [
    {
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0868462e-646c-4fe3-9ced-a733534b6a2c"
      reference_id         = "win_vm-log_analytics_workspace"
      parameter_values     = file("win_vm-log_analytics_workspace.json")
    },
    {
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/053d3325-282c-4e5c-b944-24faffd30d77"
      reference_id         = "linux_vm-log_analytics_workspace"
      parameter_values     = file("linux_vm-log_analytics_workspace.json")
    }
  ]

  #Management Group Assignment
  management_group_policy_assignment = [
    {
      name         = "log_analytics_assignment",
      description  = "Assigns the Log Analytics Initiative to the Tenant Root Management Group",
      display_name = "Enable Log Analytics for VMs",
      enforce      = false,
      location     = "westeurope",
      identity = [
        {
          type         = "UserAssigned",
          identity_ids = ["/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/techops-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/log_analytics_policy"]
        },
      ]
    }
  ]
}

