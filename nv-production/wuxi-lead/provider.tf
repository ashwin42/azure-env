terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azurerm" {
  version         = "=2.49.0"
  subscription_id = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  features {}
}
