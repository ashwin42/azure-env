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
  subnet_internal_prefix        = "${var.subnet_internal_prefix}"
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

module "azure-teamcenter" {
  source                    = "../../modules/azure-teamcenter"
  resource_group_name       = "${var.resource_group_name}"
  storage_account_name      = "${var.storage_account_name}"
  subnet_id                 = "${module.azure_core.subnet_internal_id}"
  location                  = "${var.location}"
  stage                     = "${var.stage}"
  teamcenter_vm_size        = "${var.teamcenter_vm_size}"
  teamcenter_data_disk_size = "${var.teamcenter_data_disk_size}"
  webtier_vm_size           = "${var.webtier_vm_size}"
  webtier_data_disk_size    = "${var.webtier_data_disk_size}"
  password                  = "${var.admin_password}"
  database_password         = "${var.database_password}"
}
