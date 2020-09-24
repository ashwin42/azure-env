# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name = dependency.global.outputs.resource_group.name
  subnet_id = dependency.global.outputs.subnet.id
  recovery_vault_resource_group = dependency.global.outputs.azurerm_recovery_services_vault.resource_group_name
  recovery_vault_name = dependency.global.outputs.azurerm_recovery_services_vault.name
  protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
}
