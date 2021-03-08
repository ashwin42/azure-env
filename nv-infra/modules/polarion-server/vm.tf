resource "azurerm_virtual_machine" "main" {
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  primary_network_interface_id     = azurerm_network_interface.main.id
  network_interface_ids            = [azurerm_network_interface.main.id]
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = false

  storage_image_reference {
    sku       = "2016-Datacenter"
    publisher = "MicrosoftWindowsServer"
    version   = "latest"
    offer     = "WindowsServer"
  }

  storage_os_disk {
    name              = "${var.name}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }

  os_profile {
    computer_name  = var.name
    admin_username = "nvadmin"
    admin_password = var.password
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = "W. Europe Standard Time"
  }
}

resource "null_resource" "disk_encryption" {
  count = var.vault_id != "" ? 1 : 0

  triggers = {
    storage_os_disk = azurerm_virtual_machine.main.id
  }

  provisioner "local-exec" {
    command = "az vm encryption enable --resource-group \"${var.resource_group_name}\" --name \"${var.name}\" --disk-encryption-keyvault \"${var.vault_id}\" --volume-type ALL"
  }
}

resource "azurerm_managed_disk" "data_disk" {
  name                 = "${var.name}-data1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.managed_data_disk_size
  lifecycle {
    ignore_changes = [ encryption_settings ]
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_virtual_machine.main.id
  lun                = "5"
  caching            = "ReadWrite"
}

resource "azurerm_recovery_services_protected_vm" "main" {
  resource_group_name = var.recovery_vault_resource_group
  recovery_vault_name = var.recovery_vault_name
  source_vm_id        = azurerm_virtual_machine.main.id
  backup_policy_id    = azurerm_recovery_services_protection_policy_vm.daily.id
}

data "azurerm_key_vault" "nv-infra-core" {
  name                = "nv-infra-core"
  resource_group_name = "nv-infra-core"
}
