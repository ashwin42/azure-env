data "azurerm_key_vault_secret" "nv-network-mon" {
  name         = "nv-network-mon"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

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
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
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
    admin_password = data.azurerm_key_vault_secret.nv-network-mon.value
  }

  os_profile_linux_config {
    disable_password_authentication = false
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
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.nv-network-mon.name
  source_vm_id        = azurerm_virtual_machine.main.id
  backup_policy_id    = azurerm_recovery_services_protection_policy_vm.daily.id
}

resource "azurerm_managed_disk" "data_disk" {
  name                 = "${var.name}-data1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.managed_data_disk_type
  create_option        = "Empty"
  disk_size_gb         = var.managed_data_disk_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_virtual_machine.main.id
  lun                = "5"
  caching            = "ReadWrite"
}

data "azurerm_key_vault" "nv-infra-core" {
  name                = "nv-infra-core"
  resource_group_name = "nv-infra-core"
}

resource "azurerm_recovery_services_vault" "nv-network-mon" {
  name                = "nv-network-mon-recovery-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_recovery_services_protection_policy_vm" "daily" {
  name                = "daily"
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.nv-network-mon.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 30
  }

  retention_weekly {
    count    = 12
    weekdays = ["Sunday"]
  }

  retention_monthly {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["Last"]
  }

  retention_yearly {
    count    = 1
    weekdays = ["Sunday"]
    weeks    = ["Last"]
    months   = ["December"]
  }
}

output "recovery_services" {
  value = {
    recovery_vault_name        = "${azurerm_recovery_services_vault.nv-network-mon.name}"
    protection_policy_daily_id = "${azurerm_recovery_services_protection_policy_vm.daily.id}"
  }
}
