locals {
  azurerm_provider_version   = "~> 2.99"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  additional_providers = [
    {
      alias           = "that"
      provider        = "azurerm"
      subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      blocks = {
        features = {},
      },
    }
  ]
}
