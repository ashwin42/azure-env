#
# Main TeamCenter server
#

resource "azurerm_virtual_machine" "teamcenter" {
  count                            = "${var.teamcenter_server_count}"
  name                             = "${var.application_name}${count.index}-vm"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group_name}"
  network_interface_ids            = ["${azurerm_network_interface.teamcenter_network_interface.*.id[count.index]}"]
  vm_size                          = "${var.teamcenter_vm_size}"
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
    admin_password = "${var.password}"
  }

  tags {
    stage = "${var.stage}"
  }
}

resource "azurerm_managed_disk" "teamcenter_data" {
  count                = "${var.teamcenter_server_count}"
  name                 = "${var.application_name}${count.index}-data1"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "100"

  tags {
    stage = "${var.stage}"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "teamcenter_data" {
  count              = "${var.teamcenter_server_count}"
  managed_disk_id    = "${azurerm_managed_disk.teamcenter_data.*.id[count.index]}"
  virtual_machine_id = "${azurerm_virtual_machine.teamcenter.*.id[count.index]}"
  lun                = "5"
  caching            = "ReadWrite"
}

resource "azurerm_recovery_services_protected_vm" "teamcenter" {
  count               = "${var.teamcenter_server_count}"
  resource_group_name = "${var.resource_group_name}"
  recovery_vault_name = "${azurerm_recovery_services_vault.teamcenter.name}"
  source_vm_id        = "${azurerm_virtual_machine.teamcenter.*.id[count.index]}"
  backup_policy_id    = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
}

resource "azurerm_virtual_machine_extension" "teamcenter" {
  count                = "${var.teamcenter_server_count}"
  depends_on           = ["azurerm_storage_blob.first_run"]
  name                 = "${var.application_name}${count.index}-vm-extension"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${azurerm_virtual_machine.teamcenter.*.name[count.index]}"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
      "fileUris": ["${azurerm_storage_blob.first_run.url}"]
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell -File ${azurerm_storage_blob.first_run.name} -StorageAccountKey ${var.storage_access_key} -StorageAccountName ${var.storage_account_name} -Container ${azurerm_storage_container.teamcenter_resources.name}",
      "storageAccountKey": "${var.storage_access_key}",
      "storageAccountName": "${var.storage_account_name}"
    }
  PROTECTED_SETTINGS
}

#
# GPU host for rendering previews
#

resource "azurerm_virtual_machine" "tc_gpu" {
  count                            = "${var.enable_render_server ? 1 : 0}"
  name                             = "${var.application_name}-tc-gpu-vm"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group_name}"
  network_interface_ids            = ["${azurerm_network_interface.tc_gpu_network_interface.id}"]
  vm_size                          = "${var.tc_gpu_vm_size}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = false

  storage_image_reference {
    sku       = "2016-Datacenter"
    publisher = "MicrosoftWindowsServer"
    version   = "latest"
    offer     = "WindowsServer"
  }

  storage_os_disk {
    name              = "${var.application_name}-tc-gpu-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name              = "${var.application_name}-tc-gpu-datadisk1"
    caching           = "ReadWrite"
    create_option     = "Empty"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = "${var.tc_gpu_data_disk_size}"
    lun               = "10"
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = "W. Europe Standard Time"
  }

  os_profile {
    computer_name  = "${var.application_name}"
    admin_username = "nvadmin"
    admin_password = "${var.password}"
  }

  tags {
    stage = "${var.stage}"
  }
}

resource "azurerm_recovery_services_protected_vm" "tc_gpu" {
  count               = "${var.enable_render_server ? 1 : 0}"
  resource_group_name = "${var.resource_group_name}"
  recovery_vault_name = "${azurerm_recovery_services_vault.teamcenter.name}"
  source_vm_id        = "${azurerm_virtual_machine.tc_gpu.id}"
  backup_policy_id    = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
}

#
# Licensing server
#

resource "azurerm_virtual_machine" "tc_license" {
  name                             = "${var.application_name}-license-vm"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group_name}"
  network_interface_ids            = ["${azurerm_network_interface.tc_license_network_interface.id}"]
  vm_size                          = "${var.tc_license_vm_size}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = false

  storage_image_reference {
    sku       = "2016-Datacenter"
    publisher = "MicrosoftWindowsServer"
    version   = "latest"
    offer     = "WindowsServer"
  }

  storage_os_disk {
    name              = "${var.application_name}-lic-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = "W. Europe Standard Time"
  }

  os_profile {
    computer_name  = "${var.application_name}-lic"
    admin_username = "nvadmin"
    admin_password = "${var.password}"
  }

  tags {
    stage = "${var.stage}"
  }
}

resource "azurerm_recovery_services_protected_vm" "tc_license" {
  resource_group_name = "${var.resource_group_name}"
  recovery_vault_name = "${azurerm_recovery_services_vault.teamcenter.name}"
  source_vm_id        = "${azurerm_virtual_machine.tc_license.id}"
  backup_policy_id    = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
}
