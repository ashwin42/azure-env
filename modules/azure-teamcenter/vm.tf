#
# Main TeamCenter server
#

resource "azurerm_virtual_machine" "teamcenter" {
  name                             = "${var.application_name}-vm"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group_name}"
  network_interface_ids            = ["${azurerm_network_interface.teamcenter_network_interface.id}"]
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
    name              = "${var.application_name}-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
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

resource "azurerm_managed_disk" "teamcenter_data" {
  name                 = "teamcenter-data1"
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
  managed_disk_id    = "${azurerm_managed_disk.teamcenter_data.id}"
  virtual_machine_id = "${azurerm_virtual_machine.teamcenter.id}"
  lun                = "5"
  caching            = "ReadWrite"
}

resource "azurerm_recovery_services_protected_vm" "teamcenter" {
  resource_group_name = "${var.resource_group_name}"
  recovery_vault_name = "${azurerm_recovery_services_vault.teamcenter.name}"
  source_vm_id        = "${azurerm_virtual_machine.teamcenter.id}"
  backup_policy_id    = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
}

resource "azurerm_virtual_machine_extension" "teamcenter" {
  depends_on           = ["azurerm_storage_blob.first_run"]
  name                 = "${var.application_name}-vm-extension"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${azurerm_virtual_machine.teamcenter.name}"
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
    name              = "${var.application_name}-license-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
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

resource "azurerm_managed_disk" "tc_license_data" {
  name                 = "${var.application_name}-license-data1"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "50"

  tags {
    stage = "${var.stage}"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "tc_license_data" {
  managed_disk_id    = "${azurerm_managed_disk.tc_license_data.id}"
  virtual_machine_id = "${azurerm_virtual_machine.tc_license.id}"
  lun                = "5"
  caching            = "ReadWrite"
}

resource "azurerm_recovery_services_protected_vm" "tc_license" {
  resource_group_name = "${var.resource_group_name}"
  recovery_vault_name = "${azurerm_recovery_services_vault.teamcenter.name}"
  source_vm_id        = "${azurerm_virtual_machine.tc_license.id}"
  backup_policy_id    = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
}
