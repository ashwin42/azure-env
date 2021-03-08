data "azurerm_key_vault_secret" "nv-nps" {
  name         = "nv-nps"
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

#  storage_image_reference {
#    sku       = "2016-Datacenter"
#    publisher = "MicrosoftWindowsServer"
#    version   = "latest"
#    offer     = "WindowsServer"
#  }

  storage_os_disk {
    name              = "nps-osdisk-20200528-092614"
    caching           = "ReadWrite"
    create_option     = "Attach"
    managed_disk_type = "StandardSSD_LRS"
  }

  os_profile {
    computer_name  = var.name
    admin_username = "nvadmin"
    admin_password = data.azurerm_key_vault_secret.nv-nps.value
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

data "azurerm_key_vault" "nv-infra-core" {
  name                = "nv-infra-core"
  resource_group_name = "nv-infra-core"
}

data "azurerm_key_vault_secret" "domainjoin" {
  name         = "domainjoin"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

#resource "azurerm_virtual_machine_extension" "ad_join" {
#  name                 = "ad_join"
#  location             = var.location
#  resource_group_name  = var.resource_group_name
#  virtual_machine_name = azurerm_virtual_machine.main.name
#  publisher            = "Microsoft.Compute"
#  type                 = "JsonADDomainExtension"
#  type_handler_version = "1.3"
#
#  settings           = <<SETTINGS
#        {
#            "Name": "aadds.northvolt.com",
#            "User": "northvolt\\domainjoin",
#            "Restart": "true",
#            "Options": "3"
#        }
#SETTINGS
#  protected_settings = <<PROTECTED_SETTINGS
#    {
#      "Password": "${data.azurerm_key_vault_secret.domainjoin.value}"
#    }
#  
#PROTECTED_SETTINGS
#  depends_on         = ["azurerm_virtual_machine.main"]
#}
