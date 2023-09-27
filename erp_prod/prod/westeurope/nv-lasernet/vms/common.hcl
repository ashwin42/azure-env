locals {
  providers   = ["azurerm", "netbox"]
  netbox_role = "lasernet-vms"
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