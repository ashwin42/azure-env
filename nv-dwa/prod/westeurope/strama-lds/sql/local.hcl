locals {
  providers                = ["mssql", "netbox"]
  azurerm_provider_version = ">= 3.58.0"
  additional_providers = [
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
