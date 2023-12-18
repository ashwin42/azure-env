locals {
  additional_providers = [
    {
      alias    = "parent_dns"
      provider = "azurerm"
      raw = {
        subscription_id = "coalesce(var.parent_dns_subscription_id, var.subscription_id)"
      }
      blocks = {
        features = {},
      },
    },
  ]
}
