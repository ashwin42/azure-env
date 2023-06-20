locals {
  azurerm_provider_version   = ">= 2.99"
  terraform_required_version = ">= 1.0"
  subscription_id            = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  azurerm_features           = {}
  tags = {
    project = "Siemens ASRS"
    jira    = "TOC-1208"
  }
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
      subscription_id = local.subscription_id
      blocks = {
        features = {},
      },
    },
    {
      alias           = "ad_join_keyvault"
      provider        = "azurerm"
      subscription_id = local.subscription_id
      blocks = {
        features = {},
      },
    },
  ]
}
