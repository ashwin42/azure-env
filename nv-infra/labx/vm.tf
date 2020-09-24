data "azurerm_key_vault_secret" "nv-labx" {
  name         = "nv-labx"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

resource "azurerm_availability_set" "nv_labx_avs" {
  name                = "nv_labx_avs"
  resource_group_name = var.resource_group_name
  location            = var.location
  managed             = true
}

data "azurerm_key_vault_secret" "nv-infra-core" {
  name         = "nv-labx"
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
  availability_set_id              = azurerm_availability_set.nv_labx_avs.id

  storage_image_reference {
    sku       = "2016-Datacenter"
    publisher = "MicrosoftWindowsServer"
    version   = "latest"
    offer     = "WindowsServer"
  }

  storage_os_disk {
    #name              = "${var.name}-os"
    name              = "labx-osdisk-20200422-082835"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }

  os_profile {
    computer_name  = var.name
    admin_username = "nvadmin"
    admin_password = data.azurerm_key_vault_secret.nv-labx.value
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
    command = "az vm encryption enable --resource-group \"${var.resource_group_name}\" --name \"${var.name}\" --disk-encryption-keyvault \"${var.vault_id}\" --volume-type OS"
  }
}

resource "azurerm_recovery_services_protected_vm" "main" {
  resource_group_name = var.recovery_vault_resource_group
  recovery_vault_name = var.recovery_vault_name
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
  encryption_settings {
    enabled = true
    disk_encryption_key {
      #secret_url      = "https://nv-infra-core.vault.azure.net/secrets/4F37950E-0E62-4C3C-BE62-91EB6338BB8F/d1cf29f9e90b4f9688d01f66125ab0fe"
      secret_url      = data.azurerm_key_vault_secret.encryption.id
      source_vault_id = data.azurerm_key_vault.nv-infra-core.id
    }
  }
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

data "azurerm_key_vault_secret" "encryption" {
  name         = "4F37950E-0E62-4C3C-BE62-91EB6338BB8F"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

