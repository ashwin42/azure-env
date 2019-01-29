resource "azurerm_network_security_group" "pritunl" {
  name                = "pritunl_security_group"
  resource_group_name = "${azurerm_resource_group.nv-shared.name}"
  location            = "${azurerm_resource_group.nv-shared.location}"

  security_rule {
    name                       = "Allow_Inbound_https_from_office"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "31.208.18.58/32"
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
    name                       = "Allow_Inbound_OpenVPN"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "*"
    destination_port_range     = "11122"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

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

resource "azurerm_public_ip" "pritunl" {
  name                    = "pritunl-pip"
  location                = "${azurerm_resource_group.nv-shared.location}"
  resource_group_name     = "${azurerm_resource_group.nv-shared.name}"
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "pritunl" {
  name                      = "pritunl-nic"
  location                  = "${azurerm_resource_group.nv-shared.location}"
  resource_group_name       = "${azurerm_resource_group.nv-shared.name}"
  enable_ip_forwarding      = true
  network_security_group_id = "${azurerm_network_security_group.pritunl.id}"

  ip_configuration {
    name                          = "pritunl1"
    subnet_id                     = "${local.nv_shared_1}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.101.1.10"
    public_ip_address_id          = "${azurerm_public_ip.pritunl.id}"
  }
}

resource "azurerm_virtual_machine" "pritunl" {
  name                             = "pritunl-vm"
  location                         = "${azurerm_resource_group.nv-shared.location}"
  resource_group_name              = "${azurerm_resource_group.nv-shared.name}"
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
