locals {
  azurerm_provider_version   = ">= 3"
  terraform_required_version = ">= 1.1"
  azurerm_features           = "features {}"
  setup_prefix               = "autodesk-vault"
  resource_group_name        = "autodesk-vault-rg"
}
