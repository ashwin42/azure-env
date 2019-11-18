resource "azurerm_virtual_machine" "main" {
  name                          = "${var.name}"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  primary_network_interface_id  = "${azurerm_network_interface.main.id}"
  network_interface_ids         = ["${azurerm_network_interface.main.id}"]
  vm_size                       = "${var.vm_size}"
  delete_os_disk_on_termination = false

  storage_image_reference {
    sku       = "enterprise"
    publisher = "microsoftsqlserver"
    version   = "latest"
    offer     = "sql2014sp3-ws2012r2"
  }

  storage_os_disk {
    name              = "${var.name}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }

  os_profile {
    computer_name  = "${var.name}"
    admin_username = "nvadmin"
    admin_password = "${data.azurerm_key_vault_secret.nv-production-core.value}"
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = "W. Europe Standard Time"
  }
}

resource "null_resource" "disk_encryption" {
  count = "${var.vault_id != "" ? 1 : 0}"

  triggers = {
    storage_os_disk = azurerm_virtual_machine.main.id
  }

  provisioner "local-exec" {
    command = "az vm encryption enable --resource-group \"${var.resource_group_name}\" --name \"${var.name}\" --disk-encryption-keyvault \"${var.vault_id}\" --volume-type OS"
  }
}

resource "azurerm_recovery_services_protected_vm" "main" {
  resource_group_name = "${var.recovery_vault_resource_group}"
  recovery_vault_name = "${var.recovery_vault_name}"
  source_vm_id        = "${azurerm_virtual_machine.main.id}"
  backup_policy_id    = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
}
