# Main vnet for NV Azure
resource "azurerm_virtual_network" "core_vnet" {
  name                = "nv-core-vnet"
  resource_group_name = "${var.resource_group_name}"
  address_space       = "${var.vnet_address_space}"
  location            = "${var.location}"
  dns_servers         = ["10.101.250.4", "10.101.250.5"]
}

output "core_vnet_id" {
  value = "${azurerm_virtual_network.core_vnet.id}"
}

# Subnets
data "azurerm_network_security_group" "AADDS" {
  name                = "AADDS-northvolt.com-NSG"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_subnet" "nv_domain_services" {
  name                      = "nv-domain-services"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${azurerm_virtual_network.core_vnet.name}"
  address_prefix            = "10.101.250.0/24"
  network_security_group_id = "${data.azurerm_network_security_group.AADDS.id}"
}

resource "azurerm_subnet_network_security_group_association" "nv_domain_services" {
  subnet_id                 = "${azurerm_subnet.nv_domain_services.id}"
  network_security_group_id = "${data.azurerm_network_security_group.AADDS.id}"
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.core_vnet.name}"
  address_prefix       = "${var.gateway_subnet_prefix}"
}

resource "azurerm_subnet" "nv_shared_1" {
  name                 = "nv-shared-1"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.core_vnet.name}"
  address_prefix       = "10.101.1.0/24"
}

resource "azurerm_subnet" "nv_automation_1" {
  name                 = "nv-automation-1"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.core_vnet.name}"
  address_prefix       = "10.101.2.0/24"
}

resource "azurerm_subnet" "nv_lab_1" {
  name                 = "nv-lab-1"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.core_vnet.name}"
  address_prefix       = "10.101.3.0/24"
}

output "subnet_id" {
  value = {
    "nv_shared_1"     = "${azurerm_subnet.nv_shared_1.id}"
    "nv_automation_1" = "${azurerm_subnet.nv_automation_1.id}"
    "nv_lab_1"        = "${azurerm_subnet.nv_lab_1.id}"
  }
}
