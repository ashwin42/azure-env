locals {
  subscription_name                         = "NV-Sentinel-Log_Analytics"
  subscription_id                           = "32de2a14-563c-4f79-a65e-7679f9c6b1b2"
  azurerm_subscription_id                   = "32de2a14-563c-4f79-a65e-7679f9c6b1b2"
  remote_state_azurerm_enabled              = true
  remote_state_azurerm_storage_account_name = "nvsentineltfstate"
  remote_state_azurerm_container_name       = "nv-tf-state"
  remote_state_azurerm_resource_group_name  = "nv-sentinel-tfstate"
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

