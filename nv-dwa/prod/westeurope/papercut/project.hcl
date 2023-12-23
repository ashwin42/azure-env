locals {
  project             = basename(get_terragrunt_dir())
  resource_group_name = local.project
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
      subscription_id = "8fd2d16b-30ef-4fd1-b2f2-0df001fd747d"
      blocks = {
        features = {},
      },
    },
    {
      alias           = "ad_join_keyvault"
      provider        = "azurerm"
      subscription_id = "11dd160f-0e01-4b4d-a7a0-59407e357777"
      blocks = {
        features = {},
      },
    },
  ]
  tags = {
    jira                 = "NDW-666"
    project              = "dwa papercut"
    infrastructure-owner = "techops@northvolt.com"
  }
}
