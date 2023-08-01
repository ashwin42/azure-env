locals {
  location = basename(get_parent_terragrunt_dir())
  tags = {
    region = basename(get_parent_terragrunt_dir())
  }
  additional_providers = [
    {
      alias           = "localadmin_keyvault"
      provider        = "azurerm"
      subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      blocks = {
        features = {},
      },
    },
  ]
}
