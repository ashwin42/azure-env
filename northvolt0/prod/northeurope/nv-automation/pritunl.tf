resource "azurerm_network_security_group" "pritunl" {
  name                = "pritunl_security_group"
  resource_group_name = var.resource_group_name
  location            = var.location

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
    name                       = "Allow_Inbound_ssh_from_lh_office"
    priority                   = 116
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "194.18.85.194/32"
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
    name                       = "Allow_Inbound_800xa_2"
    priority                   = 142
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "13119"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_800xa_2"
    priority                   = 143
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.22/32"
  }

  security_rule {
    name                       = "Allow_Inbound_kova"
    priority                   = 144
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "10654"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_kova"
    priority                   = 145
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.204/32"
  }

  security_rule {
    name                       = "Allow_Inbound_nv_dev"
    priority                   = 146
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "11802"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_nv_dev"
    priority                   = 147
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.205/32"
  }

  security_rule {
    name                       = "Allow_Inbound_jeil"
    priority                   = 148
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "17686"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_jeil"
    priority                   = 149
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.206/32"
  }

  security_rule {
    name                       = "Allow_Inbound_siemensbms"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "17645"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Inbound_ssh_from_labs"
    priority                   = 117
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "213.50.54.192/28"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_siemensbms"
    priority                   = 151
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.207/32"
  }

  security_rule {
    name                       = "Allow_Inbound_seci"
    priority                   = 152
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "19062"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_seci"
    priority                   = 153
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.208/32"
  }

  security_rule {
    name                       = "Allow_Inbound_flour"
    priority                   = 154
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "16098"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_flour"
    priority                   = 155
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.209/32"
  }

  security_rule {
    name                       = "Allow_Inbound_Sejong"
    priority                   = 156
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "15782"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Sejong"
    priority                   = 157
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.211/32"
  }

  security_rule {
    name                       = "Allow_Inbound_Flexlink"
    priority                   = 158
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "17791"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Flexlink"
    priority                   = 159
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.212/32"
  }

  security_rule {
    name                       = "Allow_Inbound_Tronrud"
    priority                   = 160
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "18191"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Tronrud"
    priority                   = 161
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.213/32"
  }

  security_rule {
    name                       = "Allow_Outbound_Siemens"
    priority                   = 162
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.214/32"
  }

  security_rule {
    name                       = "Allow_Inbound_Comau"
    priority                   = 163
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "13020"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Comau"
    priority                   = 164
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.215/32"
  }

  security_rule {
    name                       = "Allow_Inbound_Engie"
    priority                   = 165
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "18072"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_Outbound_Engie"
    priority                   = 166
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.216/32"
  }

  security_rule {
    name                       = "Allow_Outbound_Northvolt_RDP"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "10.101.2.210/32"
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
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "pritunl" {
  name                      = "pritunl-nic"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  enable_ip_forwarding      = true
  network_security_group_id = azurerm_network_security_group.pritunl.id

  ip_configuration {
    name                          = "pritunl1"
    subnet_id                     = local.nv_automation_1
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.101.2.10"
    public_ip_address_id          = azurerm_public_ip.pritunl.id
  }
}

resource "azurerm_virtual_machine" "pritunl" {
  name                             = "pritunl-vm"
  location                         = var.location
  resource_group_name              = var.resource_group_name
  network_interface_ids            = [azurerm_network_interface.pritunl.id]
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
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  source_vm_id        = azurerm_virtual_machine.pritunl.id
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
}

