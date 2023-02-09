terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  management_group_name = "NV Root"
  management_group_policy_assignment = [
    {
      name                 = "VM Backup Auditing",
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d"
      description          = "Audit all subscriptions for VM backups"
      display_name         = "Audit for VM backup"
    },
  ]
}

