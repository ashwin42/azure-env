# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name       = "nv_nps"
  vault_id                  = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-infra-core/providers/Microsoft.KeyVault/vaults/nv-infra-core"
}
