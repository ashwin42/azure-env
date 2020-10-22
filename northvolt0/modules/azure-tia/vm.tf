resource "azurerm_virtual_machine" "tia" {
  count                            = var.tia_server_count
  name                             = "${var.application_name}${count.index}-vm"
  location                         = var.location
  resource_group_name              = var.resource_group_name
  network_interface_ids            = [azurerm_network_interface.tia_network_interface[count.index].id]
  vm_size                          = var.tia_vm_size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = false

  storage_image_reference {
    sku       = "2016-Datacenter"
    publisher = "MicrosoftWindowsServer"
    version   = "latest"
    offer     = "WindowsServer"
  }

  storage_os_disk {
    name              = "${var.application_name}${count.index}-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = "W. Europe Standard Time"
  }

  os_profile {
    computer_name  = "${var.application_name}${count.index}"
    admin_username = "nvadmin"
    admin_password = var.password
  }

  tags = {
    stage = var.stage
  }
}

resource "azurerm_managed_disk" "tia_data" {
  count                = var.tia_server_count
  name                 = "${var.application_name}${count.index}-data1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.tia_data_disk_size

  tags = {
    stage = var.stage
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "tia_data" {
  count              = var.tia_server_count
  managed_disk_id    = azurerm_managed_disk.tia_data[count.index].id
  virtual_machine_id = azurerm_virtual_machine.tia[count.index].id
  lun                = "5"
  caching            = "ReadWrite"
}

# resource "azurerm_recovery_services_protected_vm" "tia" {
#   count               = "${var.tia_server_count}"
#   resource_group_name = "${var.resource_group_name}"
#   recovery_vault_name = "${azurerm_recovery_services_vault.tia.name}"
#   source_vm_id        = "${azurerm_virtual_machine.tia.*.id[count.index]}"
#   backup_policy_id    = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
# }
