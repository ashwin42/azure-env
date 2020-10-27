terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azurerm" {
  version         = ">=2.31.0"
  subscription_id = var.subscription_id
  features {}
}
