terraform {
  required_version = ">=0.12"
  backend "azurerm" {
    storage_account_name = "nvtfstate"
    container_name       = "nv-tf-state"
    key                  = "nv-core.tfstate"
    resource_group_name  = "nv-core"
    subscription_id      = "f23047bd-1342-4fdf-a81c-00c91500455f"
  }
}

provider "azurerm" {
  version         = "=1.34.0"
  subscription_id = var.subscription_id
}

