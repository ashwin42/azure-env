terraform {
  backend "azurerm" {
    storage_account_name = "nvtfstate"
    container_name       = "nv-tf-state"
    key                  = "lasernet.tfstate"
    resource_group_name  = "lasernet"
  }
}

provider "azurerm" {}
