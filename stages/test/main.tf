terraform {
  backend "azurerm" {
    storage_account_name = "nvautomationtest"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}

provider "azurerm" {
  version = ">= 1.19.0"
}

# provider "kubernetes" {
#   host                   = "${azurerm_kubernetes_cluster.main.kube_config.0.host}"
#   username               = "${azurerm_kubernetes_cluster.main.kube_config.0.username}"
#   password               = "${azurerm_kubernetes_cluster.main.kube_config.0.password}"
#   client_certificate     = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)}"
#   client_key             = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_key)}"
#   cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)}"
# }

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
  source                         = "../../modules/azure-teamcenter"
  resource_group_name            = "${var.resource_group_name}"
  storage_account_name           = "${var.storage_account_name}"
  storage_access_key             = "${var.storage_access_key}"
  subnet_id                      = "${module.azure_core.subnet_internal_id}"
  subnet_prefix                  = "${module.azure_core.subnet_internal_prefix}"
  location                       = "${var.location}"
  stage                          = "${var.stage}"
  teamcenter_server_count        = "${var.teamcenter_server_count}"
  teamcenter_vm_size             = "${var.teamcenter_vm_size}"
  teamcenter_data_disk_size      = "${var.teamcenter_data_disk_size}"
  enable_render_server           = "${var.enable_render_server}"
  tc_gpu_vm_size                 = "${var.tc_gpu_vm_size}"
  tc_gpu_data_disk_size          = "${var.tc_gpu_data_disk_size}"
  tc_license_vm_size             = "${var.tc_license_vm_size}"
  password                       = "${var.admin_password}"
  database_password              = "${var.database_password}"
  blob_name                      = "${var.blob_name}"
  db_server_size                 = "${var.db_server_size}"
  public_ssh_key_path            = "${var.public_ssh_key_path}"
  k8s_service_principal_id       = "${var.k8s_service_principal_id}"
  k8s_service_principal_password = "${var.k8s_service_principal_password}"
  k8s_vm_size                    = "${var.k8s_vm_size}"
  k8s_vm_count                   = "${var.k8s_vm_count}"
}

module "azure-tia" {
  source              = "../../modules/azure-tia"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${module.azure_core.subnet_internal_id}"
  subnet_prefix       = "${module.azure_core.subnet_internal_prefix}"
  location            = "${var.location}"
  stage               = "${var.stage}"
  password            = "${var.admin_password}"
}

module "azure-abb800xa" {
  source              = "../../modules/azure-vm"
  application_name    = "${var.abb800xa_application_name}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${module.azure_core.subnet_internal_id}"
  subnet_prefix       = "${module.azure_core.subnet_internal_prefix}"
  base_ip             = "${var.abb800xa_base_ip}"
  location            = "${var.location}"
  stage               = "${var.stage}"
  password            = "${var.admin_password}"
}
