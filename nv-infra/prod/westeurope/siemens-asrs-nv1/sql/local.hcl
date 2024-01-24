locals {
  providers = ["mssql", "netbox"]
  additional_providers = [
    {
      alias    = "localadmin_keyvault"
      provider = "azurerm"
      raw = {
        subscription_id = "var.azurerm_subscription_id"
      }
      blocks = {
        features = {},
      },
    },
    {
      alias           = "private_endpoint_dns_subscription"
      provider        = "azurerm"
      subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      blocks = {
        features = {},
      },
    },
  ]
}
