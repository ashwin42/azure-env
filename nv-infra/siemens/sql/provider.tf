terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azurerm" {
  version         = "=2.49.0"
  subscription_id = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  features {}
}
