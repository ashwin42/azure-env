terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.3.7"
  #source = "../../../../../tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  # Subscription Assignment
  subscription_policy_assignment = [
    {
      name              = "nv_gen_infra-log_analytics",
      subscription_name = "NV_Gen_Infra",
      description       = "Assigns the vm_enable_log_analytics policy definition to subscription NV_Gen_Infra",
      display_name      = "NV_Gen_Infra-Enable_Log_Analytics",
      enforce           = false,
      location          = "eu-west1",
    },
  ]
  #Policy Set
  policy_set_name         = "log_analytics_initiative"
  policy_set_display_name = "Log Analytics Initiative"
  policy_set_description  = "Enables Log Analytics. Managed by Terraform"
  policy_definition_reference = [
    {
      reference_id = "log_analytics_initiative"
    }
  ]
  #Policies
  policy_definition = [
    {
      name         = "vm_enable_log_analytics",
      display_name = "Log Analytics for VMs",
      description  = "Enables Log Analytics for VMs. Managed by Terraform",
      policy_rule  = <<POLICY_RULE
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Compute/virtualMachines"
      }
    ]
  },
  "then": {
    "effect": "AuditIfNotExists",
    "details": {
        "type": "Microsoft.Compute/virtualMachines/extensions",
        "existenceCondition": {
            "allOf": [
                {
                    "field": "Microsoft.Compute/virtualMachines/extensions/publisher",
                    "equals": "Microsoft.EnterpriseCloud.Monitoring"
                },
                {
                    "field": "Microsoft.Compute/virtualMachines/extensions/type",
                    "in": [
                        "MicrosoftMonitoringAgent",
                        "OmsAgentForLinux"
                    ]
                },
                {
                    "field": "Microsoft.Compute/virtualMachines/extensions/provisioningState",
                    "equals": "Succeeded"
                },
                {
                    "field": "Microsoft.Compute/virtualMachines/extensions/settings.workspaceId",
                    "equals": "4dc9d181-4ce9-4b8e-a86d-133b47364298"
                }
            ]
        }
    }
  }
}
POLICY_RULE
    },
  ]
}

