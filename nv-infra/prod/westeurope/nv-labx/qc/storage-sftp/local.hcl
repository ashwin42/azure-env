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

  tags = {
    business-unit = "151058 Quality Control - LA"
    department    = "151 Manufacturing Support - LA"
    cost-center   = "151058251 Quality Control - LA"
  }
}
