locals {
  name              = "abb800xa"
  ip_address        = "10.101.2.20"
  second_ip_address = "10.101.2.21"
}

data "azurerm_key_vault_secret" "abb800xa" {
  name         = "abb800xa-nvadmin"
  key_vault_id = "${data.azurerm_key_vault.nv_core.id}"
}

resource "azurerm_network_security_group" "abb800xa" {
  name                = "${local.name}-sg"
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
}

resource "azurerm_network_interface" "abb800xa_secondary_nic" {
  name                      = "${local.name}-second-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.abb800xa.id}"

  ip_configuration {
    name                          = "${local.name}-second-nic_config"
    subnet_id                     = "${local.nv_automation_1}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${local.second_ip_address}"
  }
}

module "abb800xa" {
  source              = "../modules/windows-server"
  security_group_id   = "${azurerm_network_security_group.abb800xa.id}"
  password            = "${data.azurerm_key_vault_secret.abb800xa.value}"
  ipaddress           = "${local.ip_address}"
  name                = "${local.name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${local.nv_automation_1}"
  vault_id            = "${data.azurerm_key_vault.nv_core.id}"
  recovery_vault_name = "${data.terraform_remote_state.nv-shared.recovery_services.recovery_vault_name}"
  backup_policy_id    = "${data.terraform_remote_state.nv-shared.recovery_services.protection_policy_daily_id}"
  secondary_nic       = "${azurerm_network_interface.abb800xa_secondary_nic.id}"
}

resource "azurerm_network_security_group" "abb800xa_2" {
  name                = "abb800xa-2-sg"
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
}

resource "azurerm_network_interface" "abb800xa_2_secondary_nic" {
  name                      = "abb800xa-2-second-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.abb800xa_2.id}"

  ip_configuration {
    name                          = "abb800xa-2-second-nic_config"
    subnet_id                     = "${local.nv_automation_1}"
    private_ip_address_allocation = "static"
    private_ip_address            = "10.101.2.23"
  }
}

module "abb800xa_2" {
  source              = "../modules/windows-server"
  security_group_id   = "${azurerm_network_security_group.abb800xa_2.id}"
  password            = "${data.azurerm_key_vault_secret.abb800xa.value}"
  ipaddress           = "10.101.2.22"
  name                = "abb800xa-2"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${local.nv_automation_1}"
  vault_id            = "${data.azurerm_key_vault.nv_core.id}"
  recovery_vault_name = "${data.terraform_remote_state.nv-shared.recovery_services.recovery_vault_name}"
  backup_policy_id    = "${data.terraform_remote_state.nv-shared.recovery_services.protection_policy_daily_id}"
  secondary_nic       = "${azurerm_network_interface.abb800xa_2_secondary_nic.id}"
}
