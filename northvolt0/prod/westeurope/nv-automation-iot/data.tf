data "terraform_remote_state" "nv-core" {
  backend = "azurerm"

  config = {
    resource_group_name  = "nv-core"
    storage_account_name = "nvtfstate"
    container_name       = "nv-tf-state"
    key                  = "nv-core.tfstate"
    subscription_id      = var.subscription_id
  }
}
