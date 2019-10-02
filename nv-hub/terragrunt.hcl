remote_state {
  backend = "azurerm"

  config = {
    storage_account_name = "nvhubtfstate"
    container_name       = "nv-tf-state"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "nv-hub-core"
    subscription_id      = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  }
}

inputs = {
  environment       = "prod"
  subscription_name = "nv-hub"
  location          = "westeurope"
}
