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

resource "azurerm_storage_blob" "download_and_unzip" {
  depends_on             = ["azurerm_storage_container.teamcenter_resources"]
  name                   = "download_and_unzip_v1.ps1"
  resource_group_name    = "${var.resource_group_name}"
  storage_account_name   = "${var.storage_account_name}"
  storage_container_name = "${azurerm_storage_container.teamcenter_resources.name}"
  type                   = "block"
  source                 = "${path.module}/scripts/download_and_unzip_v1.ps1"
}

resource "azurerm_virtual_machine_extension" "teamcenter" {
  depends_on           = ["azurerm_storage_blob.download_and_unzip"]
  name                 = "${var.application_name}-vm-extension"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${azurerm_virtual_machine.teamcenter.name}"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
      "fileUris": ["${azurerm_storage_blob.download_and_unzip.url}"]
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell -File ${azurerm_storage_blob.download_and_unzip.name} -StorageAccountKey ${var.storage_access_key} -StorageAccountName ${var.storage_account_name} -Container ${azurerm_storage_container.teamcenter_resources.name} -Blob ${var.blob_name} -Target ${var.targetdir}",
      "storageAccountKey": "${var.storage_access_key}",
      "storageAccountName": "${var.storage_account_name}"
    }
  PROTECTED_SETTINGS
}

# resource "azurerm_virtual_machine" "tc_gpu" {
#   name                             = "${var.application_name}-tc-gpu-vm"
#   location                         = "${var.location}"
#   resource_group_name              = "${var.resource_group_name}"
#   network_interface_ids            = ["${azurerm_network_interface.tc_gpu_network_interface.id}"]
#   vm_size                          = "${var.tc_gpu_vm_size}"
#   delete_os_disk_on_termination    = true
#   delete_data_disks_on_termination = false


#   storage_image_reference {
#     sku       = "2016-Datacenter"
#     publisher = "MicrosoftWindowsServer"
#     version   = "latest"
#     offer     = "WindowsServer"
#   }


#   storage_os_disk {
#     name              = "${var.application_name}-tc-gpu-osdisk1"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }


#   storage_data_disk {
#     name              = "${var.application_name}-tc-gpu-datadisk1"
#     caching           = "ReadWrite"
#     create_option     = "Empty"
#     managed_disk_type = "StandardSSD_LRS"
#     disk_size_gb      = "${var.webtier_data_disk_size}"
#     lun               = "10"
#   }


#   os_profile_windows_config {
#     provision_vm_agent = true
#     timezone           = "W. Europe Standard Time"
#   }


#   os_profile {
#     computer_name  = "${var.application_name}"
#     admin_username = "nvadmin"
#     admin_password = "${var.password}"
#   }


#   tags {
#     stage = "${var.stage}"
#   }
# }

