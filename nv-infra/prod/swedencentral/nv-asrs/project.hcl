locals {
  project_name                  = basename(get_terragrunt_dir())
  resource_group_name           = "nv-asrs-rg"
  recovery_vault_resource_group = "nv-asrs-rg"
  recovery_vault_name           = "nv-asrs-rv"
  protection_policy_daily_id    = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-asrs-rg/providers/Microsoft.RecoveryServices/vaults/nv-asrs-rv/backupPolicies/DefaultPolicy"
  subscription_id               = "11dd160f-0e01-4b4d-a7a0-59407e357777"

  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "ASRS Thousand Eyes"
    jira                 = "HELP-125020"
    business-unit        = "109 Digitalization IT - AB"
    department           = "109035 Operations & Infrastructure - AB"
    cost-center          = "109035060 TechOps"
    system-owner         = "techops@northvolt.com"
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
