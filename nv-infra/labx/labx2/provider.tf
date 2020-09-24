terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azurerm" {
  version         = "=1.34.0"
  subscription_id = "11dd160f-0e01-4b4d-a7a0-59407e357777"
}

data "azurerm_key_vault_secret" "nv-labx" {
  name         = "nv-labx"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

data "azurerm_key_vault_secret" "nv-infra-core" {
  name         = "nv-labx"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

data "azurerm_key_vault" "nv-infra-core" {
  name                = "nv-infra-core"
  resource_group_name = "nv-infra-core"
}


