remote_state {
  backend = "azurerm"

  config = {
    storage_account_name = "nvproductiontfstate"
    container_name       = "nv-tf-state"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "nv-production-core"
    subscription_id      = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  }
}

inputs = {
  environment       = "prod"
  subscription_name = "nv-production"
  location          = "westeurope"
}
