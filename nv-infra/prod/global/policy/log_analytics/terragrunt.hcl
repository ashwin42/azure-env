terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.4.0"
  #source = "../../../../../../tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  #Management Group Assignments
  management_group_policy_assignment = [
    {
      name                 = "dd6727939e09428fbd1d9548",
      management_group_id  = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0868462e-646c-4fe3-9ced-a733534b6a2c"
      description          = "Assigns a policy for Log Analytics extension for Windows VM's to the Tenant Root Management Group",
      display_name         = "Deploy - Configure Log Analytics extension to be enabled on Windows virtual machines",
      enforce              = false,
      location             = "westeurope",
      parameters           = file("win_vm-log_analytics_workspace.json")
      identity = [
        {
          type         = "UserAssigned",
          identity_ids = ["/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/techops-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/log_analytics_policy"]
        },
      ]
    },
    {
      name                 = "3c45be75774f43c495b52675",
      management_group_id  = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/053d3325-282c-4e5c-b944-24faffd30d77"
      description          = "Assigns the Log Analytics Initiative to the Tenant Root Management Group",
      display_name         = "Deploy Log Analytics extension for Linux VMs",
      enforce              = false,
      location             = "westeurope",
      parameters           = file("linux_vm-log_analytics_workspace.json")
      identity = [
        {
          type         = "UserAssigned",
          identity_ids = ["/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/techops-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/log_analytics_policy"]
        },
      ]
    }
  ]
}

