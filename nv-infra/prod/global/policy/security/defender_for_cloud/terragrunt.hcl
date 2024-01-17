terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.10.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group_policy_assignments = [
    {
      name                          = "DefenderForCloud"
      display_name                  = "Security: Azure Defender for Cloud should be enabled for all subscriptions"
      description                   = "Enforces Azure Defender for Cloud on nv_root management group"
      location                      = "swedencentral"
      management_group_display_name = "NV Root"
      policy_definition_id          = "/providers/Microsoft.Management/managementGroups/nv_root/providers/Microsoft.Authorization/policyDefinitions/5062eaad-cba5-4110-9941-fb9c07c8d27c"
      identity = {
        type = "SystemAssigned"
      }
    },
  ]
}

