# -- Desigo CC --
data "azurerm_key_vault_secret" "nv-siemens-desigo" {
  name         = "nv-siemens-desigo"
  key_vault_id = "${data.azurerm_key_vault.nv-infra-core.id}"
}

module "nv-siemens-desigo" {
  source              = "../modules/windows-server"
  name                = "desigo"
  ipaddress           = "10.44.1.135"
  password            = "${data.azurerm_key_vault_secret.nv-siemens-desigo.value}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = azurerm_subnet.siemens_system_subnet.id
  vault_id            = "${data.azurerm_key_vault.nv-infra-core.id}"
  recovery_vault_name = var.recovery_vault_name
  backup_policy_id    = var.backup_policy_id
  vm_size             = "Standard_D4s_v3"
  managed_disk_type   = "Premium_LRS"
  managed_disk_size   = "1000"
}

# -- VMS --
data "azurerm_key_vault_secret" "nv-siemens-vms" {
  name         = "nv-siemens-vms"
  key_vault_id = "${data.azurerm_key_vault.nv-infra-core.id}"
}

module "nv-siemens-vms" {
  source              = "../modules/windows-server"
  name                = "vms"
  ipaddress           = "10.44.1.136"
  password            = "${data.azurerm_key_vault_secret.nv-siemens-vms.value}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = azurerm_subnet.siemens_system_subnet.id
  vault_id            = "${data.azurerm_key_vault.nv-infra-core.id}"
  recovery_vault_name = var.recovery_vault_name
  backup_policy_id    = var.backup_policy_id
  vm_size             = "Standard_D8s_v3"
}
