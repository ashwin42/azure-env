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
      name                 = "key_vault-soft_delete",
      management_group_id  = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d"
      description          = "Assigns a policy to audit the use of soft delete on all key vaults",
      display_name         = "Key vaults should have soft delete enabled",
      enforce              = false,
      location             = "westeurope",
    },
  ]
}

