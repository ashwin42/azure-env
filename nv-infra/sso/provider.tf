terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azuread" {
  version = "=1.1.1"
}
