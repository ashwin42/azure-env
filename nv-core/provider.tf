terraform {
  backend "azurerm" {
    storage_account_name = "nvtfstate"
    container_name       = "nv-tf-state"
    key                  = "nv-core.tfstate"
  }
}

provider "azurerm" {
  version = ">= 1.19.0"
}
