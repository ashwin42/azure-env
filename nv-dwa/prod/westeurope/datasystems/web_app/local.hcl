locals {
  providers = ["netbox"]
  additional_providers = [
    {
      alias    = "private_endpoint_dns_subscription"
      provider = "azurerm"
      raw = {
        subscription_id = "var.private_endpoint_dns_zone_subscription_id"
      }
      blocks = {
        features = {},
      },
    },
  ]
}
