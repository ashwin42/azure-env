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

  storage_data_disk {
    name              = "${var.application_name}-datadisk1"
    caching           = "ReadWrite"
    create_option     = "Empty"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = "${var.teamcenter_data_disk_size}"
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

resource "azurerm_storage_blob" "teamcenter-prereqs" {
  depends_on             = ["azurerm_storage_container.teamcenter_resources"]
  name                   = "install_prereqs.ps1"
  resource_group_name    = "${var.resource_group_name}"
  storage_account_name   = "${var.storage_account_name}"
  storage_container_name = "${azurerm_storage_container.teamcenter_resources.name}"
  type                   = "block"
  source                 = "${path.module}/scripts/install_prereqs.ps1"
}

resource "azurerm_virtual_machine_extension" "teamcenter" {
  depends_on           = ["azurerm_storage_blob.teamcenter-prereqs"]
  name                 = "${var.application_name}-vm-extension"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${azurerm_virtual_machine.teamcenter.name}"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.8"

  settings = <<SETTINGS
    {
        "fileUris": ["${azurerm_storage_blob.teamcenter-prereqs.url}"],
        "commandToExecute": "powershell.exe install_prereqs.ps1"
    }
SETTINGS
}

resource "azurerm_virtual_machine" "webtier" {
  name                             = "${var.application_name}-webtier-vm"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group_name}"
  network_interface_ids            = ["${azurerm_network_interface.webtier_network_interface.id}"]
  vm_size                          = "${var.webtier_vm_size}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = false

  storage_image_reference {
    sku       = "2016-Datacenter"
    publisher = "MicrosoftWindowsServer"
    version   = "latest"
    offer     = "WindowsServer"
  }

  storage_os_disk {
    name              = "${var.application_name}-webtier-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name              = "${var.application_name}-webtier-datadisk1"
    caching           = "ReadWrite"
    create_option     = "Empty"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = "${var.webtier_data_disk_size}"
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
