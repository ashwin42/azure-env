terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.3.9"
  #source = "../../../../../../tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  management_group_name  = "Tenant Root Group"
  service_principal_name = "log_analytics_policy"
  role_definition_name   = "Log Analytics Contributor"

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


  #Policy Set (Initiative)
  policy_set_name         = "log_analytics_initiative"
  policy_set_display_name = "Log Analytics for VMs Initiative"
  policy_set_description  = "Enables VMs to ship logs to the SentinelasSIEM Log Analytics Workspace"
  policy_definition_reference = [
    {
      reference_id = "log_analytics_initiative"
    }
  ]

  #Policies
  policy_definition = [
    {
      name                  = "win_vm-log_analytics",
      display_name          = "Log Analytics for Windows VMs",
      description           = "Log Analytics extension for Windows VMs if the VM Image (OS) is in the list defined and the extension is not installed",
      management_group_name = "Tenant Root Group"
      policy_rule           = file("win_vm-log_analytics.json")
      parameters            = file("win_vm-log_analytics-parameters.json")
      metadata              = file("category_monitoring.json")
    },
    {
      name                  = "linux_vm-enable_log_analytics",
      display_name          = "Log Analytics for Linux VMs",
      description           = "Log Analytics extension for Linux VMs if the VM Image (OS) is in the list defined and the extension is not installed",
      management_group_name = "Tenant Root Group"
      policy_rule           = file("linux_vm-log_analytics.json")
      parameters            = file("linux_vm-log_analytics-parameters.json")
      metadata              = file("category_monitoring.json")
    },
  ]
}

