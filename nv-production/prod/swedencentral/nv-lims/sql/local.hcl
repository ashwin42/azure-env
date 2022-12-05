locals {
  azurerm_provider_version = ">= 2.99"
  providers                = ["mssql"]
  additional_providers = [
    {
      alias           = "that"
      provider        = "azurerm"
      subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      blocks = {
        features = {},
      },
    },
    {
      alias           = "localadmin_keyvault"
      provider        = "azurerm"
      subscription_id = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
      blocks = {
        features = {},
      },
    },
  ]
}
