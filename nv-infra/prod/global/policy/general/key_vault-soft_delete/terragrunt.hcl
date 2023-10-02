terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.55"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group_policy_assignments = [
    {
      name                          = "key_vault-soft_delete"
      display_name                  = "Key vaults should have soft delete enabled"
      policy_definition_id          = "/providers/Microsoft.Authorization/policyDefinitions/1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d"
      description                   = "Assigns a policy to audit the use of soft delete on all key vaults"
      management_group_display_name = "NV Root"
      enforce                       = false
      location                      = "westeurope"
    },
  ]
}

