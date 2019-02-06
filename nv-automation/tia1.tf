resource "azurerm_managed_disk" "tia1_os" {
  name                 = "tia-os1"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "StandardSSD_LRS"
  os_type              = "Windows"
  create_option        = "Copy"
  source_resource_id   = "/subscriptions/f23047bd-1342-4fdf-a81c-00c91500455f/resourceGroups/nv-automation/providers/Microsoft.Compute/snapshots/tia_os_disk1_2019-01-29"
}

resource "azurerm_managed_disk" "tia1_data" {
  name                 = "tia-data1"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Copy"
  source_resource_id   = "/subscriptions/f23047bd-1342-4fdf-a81c-00c91500455f/resourceGroups/nv-automation/providers/Microsoft.Compute/snapshots/tia_data_disk1_2019-01-29"
  disk_size_gb         = "100"
}

resource "azurerm_virtual_machine_data_disk_attachment" "tia1_data" {
  managed_disk_id    = "${azurerm_managed_disk.tia1_data.id}"
  virtual_machine_id = "${azurerm_virtual_machine.tia1.id}"
  lun                = "5"
  caching            = "ReadWrite"
}

resource "azurerm_network_security_group" "tia_security_group" {
  name                = "tia_security_group"
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

resource "azurerm_network_interface" "tia1_network_interface" {
  name                      = "tia1-network_interface"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.tia_security_group.id}"

  ip_configuration {
    name                          = "tia1-nic_config"
    subnet_id                     = "${local.nv_automation_1}"
    private_ip_address_allocation = "static"
    private_ip_address            = "10.101.2.200"
  }
}

resource "azurerm_virtual_machine" "tia1" {
  name                             = "tia1"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group_name}"
  network_interface_ids            = ["${azurerm_network_interface.tia1_network_interface.id}"]
  vm_size                          = "Standard_D4_v3"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false

  storage_os_disk {
    name            = "tia-os1"
    os_type         = "Windows"
    create_option   = "Attach"
    managed_disk_id = "${azurerm_managed_disk.tia1_os.id}"
  }
  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = "W. Europe Standard Time"
  }
}
