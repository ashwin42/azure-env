terraform {
  required_version = "<=0.12.5"
  backend "azurerm" {
    storage_account_name = "nvtfstate"
    container_name       = "nv-tf-state"
    key                  = "nv-core.tfstate"
    resource_group_name  = "nv-core"
  }
}

provider "azurerm" {
  version = ">= 1.19.0"
}
