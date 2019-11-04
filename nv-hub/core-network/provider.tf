terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = "=1.34.0"
  subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
}
