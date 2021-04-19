resource "azurerm_virtual_machine" "tia" {
  name                          = local.fullname
  location                      = var.location
  resource_group_name           = var.resource_group_name
  network_interface_ids         = [azurerm_network_interface.tia.id]
  vm_size                       = var.vm_size
  delete_os_disk_on_termination = false

  storage_os_disk {
    name              = "${local.fullname}-os"
    os_type           = "Windows"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }

  os_profile {
    computer_name  = local.fullname
    admin_username = "nvadmin"
    admin_password = var.password
  }

  storage_image_reference {
    id = var.image
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = "W. Europe Standard Time"
  }
}

resource "null_resource" "tia_encryption" {
  count = var.vault_id != "" ? 1 : 0

  triggers = {
    storage_os_disk = azurerm_virtual_machine.tia.id
  }

  provisioner "local-exec" {
    command = "az vm encryption enable --resource-group \"${var.resource_group_name}\" --name \"${local.fullname}\" --disk-encryption-keyvault \"${var.vault_id}\" --volume-type OS --subscription ${var.subscription_id}"
  }
}

resource "azurerm_recovery_services_protected_vm" "tia" {
  resource_group_name = var.recovery_vault_resource_group
  recovery_vault_name = var.recovery_vault_name
  source_vm_id        = azurerm_virtual_machine.tia.id
  backup_policy_id    = var.backup_policy_id
}

data "azurerm_key_vault" "nv_core" {
  name                = "nv-core"
  resource_group_name = "nv-core"
}

data "azurerm_key_vault_secret" "domainjoin" {
  name         = "domainjoin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

resource "azurerm_virtual_machine_extension" "ad_join" {
  count                = var.ad_join == "" ? 0 : 1
  name                 = "ad_join"
  location             = var.location
  resource_group_name  = var.resource_group_name
  virtual_machine_name = azurerm_virtual_machine.tia.name
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  settings = <<SETTINGS
        {
            "Name": "aadds.northvolt.com",
            "User": "domainjoin@northvolt.com",
            "Restart": "true",
            "Options": "3"
        }
SETTINGS


  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password": "${data.azurerm_key_vault_secret.domainjoin.value}"
    }
  
PROTECTED_SETTINGS


  depends_on = [azurerm_virtual_machine.tia, null_resource.tia_encryption]
}

