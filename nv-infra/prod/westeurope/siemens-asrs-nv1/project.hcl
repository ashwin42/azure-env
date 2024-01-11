locals {
  resource_group_name = "asrs-nv1-prod-rg"
  recovery_vault_name = "asrs-nv1-prod-rv"
  subscription_id     = "11dd160f-0e01-4b4d-a7a0-59407e357777"

  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "Siemens ASRS"
    jira                 = "HELP-105324"
    system-owner         = ""
    data-owner           = "pooyan@northvolt.com"
    global-process-owner = "ashwin.sathrughnan@northvolt.com"
    business-unit        = ""
    department           = ""
    cost-center          = ""
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
