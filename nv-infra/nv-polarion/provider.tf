terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azurerm" {
  version         = "=1.38.0"
  subscription_id = "11dd160f-0e01-4b4d-a7a0-59407e357777"
}

provider "azurerm" {
  alias           = "hub"
  subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
}
