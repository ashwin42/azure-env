terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azurerm" {
  version         = "=1.34.0"
  subscription_id = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
}
