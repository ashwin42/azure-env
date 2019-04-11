terraform {
  backend "azurerm" {
    storage_account_name = "nvautomationtest"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}

provider "azurerm" {
  version = ">= 1.21.0"
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
  gateway_subnet_prefix         = "${var.gateway_subnet_address_prefix}"
  location                      = "${var.location}"
  stage                         = "${var.stage}"
}

module "azure_vpn" {
  source                   = "../../modules/azure-vpn"
  resource_group_name      = "${var.resource_group_name}"
  virtual_network_name     = "${module.azure_core.virtual_network_name}"
  gateway_subnet_id        = "${module.azure_core.gateway_subnet_id}"
  local_network_gateway_id = "${module.azure_core.gamla_brogatan_26_local_gateway}"
  gateway_connection_psk   = "${var.gateway_connection_psk}"
  location                 = "${var.location}"
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

resource "azurerm_network_security_group" "abb800xa_secondary_security_group" {
  name                = "${var.abb800xa_application_name}0_secondary_security_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  security_rule {
    name                       = "Allow_Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_RDP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "abb800xa_secondary_nic" {
  name                      = "${var.abb800xa_application_name}0-second-network_interface"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.abb800xa_secondary_security_group.id}"

  ip_configuration {
    name                          = "${var.abb800xa_application_name}0-second-network_interface_ip_config"
    subnet_id                     = "${module.azure_core.subnet_internal_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "10.1.10.220"
  }
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
  secondary_nic       = "${azurerm_network_interface.abb800xa_secondary_nic.id}"
}
