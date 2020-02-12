remote_state {
  backend = "azurerm"

  config = {
    storage_account_name = "nvinfratfstate"
    container_name       = "nv-tf-state"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "nv-infra-core"
    subscription_id      = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  }
}

inputs = {
  environment       = "prod"
  subscription_name = "nv-gen-infra"
  location          = "westeurope"
}