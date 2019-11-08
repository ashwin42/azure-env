resource "azurerm_network_security_group" "pritunl" {
  name                = "pritunl_security_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  security_rule {
    name                       = "Allow_Inbound_https_from_office"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Inbound_ssh_from_office"
    priority                   = 115
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "31.208.18.58/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Inbound_http_for_letsencrypt"
    priority                   = 118
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Inbound_Hirano"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "17676"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Hirano"
    priority                   = 126
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8735"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.200/32"
  }

  security_rule {
    name                       = "Allow_Inbound_Zeppelin"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "19750"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Zeppelin"
    priority                   = 128
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8735"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.201/32"
  }

  security_rule {
    name                       = "Allow_Inbound_ABB"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "17654"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_ABB"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.20/32"
  }

  security_rule {
    name                       = "Allow_Inbound_CIS"
    priority                   = 131
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "18930"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_CIS"
    priority                   = 132
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8735"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.202/32"
  }

  security_rule {
    name                       = "Allow_Inbound_Siemens"
    priority                   = 133
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "19927"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Siemens_TIA"
    priority                   = 134
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8735"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.200/30"
  }

  security_rule {
    name                       = "Allow_Outbound_Siemens_RDP"
    priority                   = 135
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.200/30"
  }

  security_rule {
    name                       = "Allow_Inbound_Northvolt"
    priority                   = 136
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "19005"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Northvolt"
    priority                   = 137
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8735"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.210/32"
  }
    security_rule {
    name                       = "Allow_Inbound_durr"
    priority                   = 138
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "10815"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_durr"
    priority                   = 139
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8735"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.203/32"
  }

    security_rule {
    name                       = "Allow_Inbound_nv_tia_poc"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "10829"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_nv_tia_poc"
    priority                   = 141
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8735"
    source_address_prefix      = "*"
    destination_address_prefix = "10.1.10.200/32"
  }

  security_rule {
    name                       = "Deny_VNET"
    priority                   = 4096
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
  
}

resource "azurerm_public_ip" "pritunl" {
  name                    = "pritunl-pip"
  location                = "${var.location}"
  resource_group_name     = "${var.resource_group_name}"
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "pritunl" {
  name                      = "pritunl-nic"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  enable_ip_forwarding      = true
  network_security_group_id = "${azurerm_network_security_group.pritunl.id}"

  ip_configuration {
    name                          = "pritunl1"
    subnet_id                     = "${local.nv_automation_1}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.101.2.10"
    public_ip_address_id          = "${azurerm_public_ip.pritunl.id}"
  }
}

resource "azurerm_virtual_machine" "pritunl" {
  name                             = "pritunl-vm"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group_name}"
  network_interface_ids            = ["${azurerm_network_interface.pritunl.id}"]
  vm_size                          = "Standard_D2s_v3"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "pritunlosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "pritunl1"
    admin_username = "nvadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_recovery_services_protected_vm" "pritunl" {
  resource_group_name = "nv-shared"
  recovery_vault_name = "${data.terraform_remote_state.nv-shared.recovery_services.recovery_vault_name}"
  source_vm_id        = "${azurerm_virtual_machine.pritunl.id}"
  backup_policy_id    = "${data.terraform_remote_state.nv-shared.recovery_services.protection_policy_daily_id}"
}
