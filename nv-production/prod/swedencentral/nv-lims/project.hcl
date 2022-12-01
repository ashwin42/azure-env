locals {
  azurerm_provider_version   = ">= 3.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  setup_prefix               = basename(get_terragrunt_dir())
  resource_group_name        = "${local.setup_prefix}-rg"
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

