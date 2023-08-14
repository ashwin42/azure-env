terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  management_group_policy_assignments = [
    {
      name                          = "periodicassessment_audit"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/bd876905-5b84-4f73-ab2d-2e7a7c4568d9"
      display_name                  = "Patching: Periodic Assessments Audit - All Subscriptions"
      description                   = "Audits the periodic assessment of patch compliance for Azure VMs"
      location                      = "swedencentral"
      management_group_display_name = "NV Root"
      enforce                       = false
    },
  ]
}

