locals {
  subscription_name                         = "NV-TP-Dev"
  subscription_id                           = "4f4f41c2-b6ab-4b6d-8a6d-a2780d26cf8b"
  azurerm_subscription_id                   = "4f4f41c2-b6ab-4b6d-8a6d-a2780d26cf8b"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = replace(lower("${local.subscription_name}tfstate"), "/[-_]/", "")
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = replace("${local.subscription_name}-tfstate-rg", "/[_]/", "-")
  providers                                 = ["azurerm"]
  azurerm_features                          = {}
  additional_providers = [
    {
      alias           = "that"
      provider        = "azurerm"
      subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      blocks = {
        features = {},
      },
    },
  ]
}

