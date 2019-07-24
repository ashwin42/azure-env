terraform {
  required_version = "0.11.14"
  backend "azurerm" {
    storage_account_name = "nvtfstate"
    container_name       = "nv-tf-state"
    key                  = "nv-shared.tfstate"
  }
}

provider "azurerm" {
  version = ">= 1.19.0"
}

data "terraform_remote_state" "nv-core" {
  backend = "azurerm"

  config {
    storage_account_name = "nvtfstate"
    container_name       = "nv-tf-state"
    key                  = "nv-core.tfstate"
  }
}
