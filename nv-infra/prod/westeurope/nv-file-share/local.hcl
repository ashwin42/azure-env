locals {
  providers = ["netbox"]
  additional_providers = [
    {
      alias           = "private_endpoint_dns_subscription"
      provider        = "azurerm"
      subscription_id = "11dd160f-0e01-4b4d-a7a0-59407e357777"
      blocks = {
        features = {},
      },
    },
  ]
}
