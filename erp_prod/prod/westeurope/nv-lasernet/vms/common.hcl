locals {
  providers   = ["azurerm", "netbox"]
  netbox_role = "lasernet-vms"
  recovery_vault_name = "nv-lasernet-rv"
  recovery_services_protection_policy_id = "/subscriptions/810a32ab-57c8-430a-a3ba-83c5ad49e012/resourceGroups/nv-lasernet/providers/Microsoft.RecoveryServices/vaults/nv-lasernet-rv/backupPolicies/daily"
  recovery_vault_resource_group = "nv-lasernet"
  additional_providers = [
    {
      alias           = "localadmin_keyvault"
      provider        = "azurerm"
      subscription_id = "810a32ab-57c8-430a-a3ba-83c5ad49e012"
      blocks = {
        features = {},
      },
    },
    {
      alias           = "ad_join_keyvault"
      provider        = "azurerm"
      subscription_id = "11dd160f-0e01-4b4d-a7a0-59407e357777"
      blocks = {
        features = {},
      },
    },
  ]
}