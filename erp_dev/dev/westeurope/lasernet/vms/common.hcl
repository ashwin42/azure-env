locals {
  providers                              = ["azurerm", "netbox"]
  netbox_role                            = "lasernet"
  recovery_vault_name                    = "lasernet-rv"
  recovery_services_protection_policy_id = "/subscriptions/2a42c4da-13f8-4cff-be34-3d05a20282e6/resourceGroups/lasernet/providers/Microsoft.RecoveryServices/vaults/lasernet-rv/backupPolicies/daily"
  recovery_vault_resource_group          = "nv-lasernet"
  additional_providers = [
    {
      alias           = "localadmin_keyvault"
      provider        = "azurerm"
      subscription_id = "2a42c4da-13f8-4cff-be34-3d05a20282e6"
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
