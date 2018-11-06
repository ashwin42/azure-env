terraform {
  backend "azurerm" {
    storage_account_name = "nvautomationtest"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}

provider "azurerm" {}

module "azure_core" {
  source                        = "../../modules/azure-core"
  resource_group_name           = "${var.resource_group_name}"
  virtual_network_address_space = "${var.virtual_network_address_space}"
  location                      = "${var.location}"
  stage                         = "${var.stage}"
}

module "azure_vpn" {
  source                        = "../../modules/azure-vpn"
  resource_group_name           = "${var.resource_group_name}"
  virtual_network_name          = "${module.azure_core.virtual_network_name}"
  gateway_subnet_address_prefix = "${var.gateway_subnet_address_prefix}"
  local_network_gateway_id      = "${module.azure_core.gamla_brogatan_26_local_gateway}"
  gateway_connection_psk        = "${var.gateway_connection_psk}"
  location                      = "${var.location}"
  stage                         = "${var.stage}"
}
