data "azurerm_key_vault_secret" "nv-polarion-prod" {
  name         = "nv-polarion-prod"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

data "azurerm_key_vault" "nv-infra-core" {
  name                = "nv-infra-core"
  resource_group_name = "nv-infra-core"
}

module "nv-polarion-prod" {
  source                 = ".//modules/polarion-server"
  security_group_id      = azurerm_network_security_group.nv_polarion_nsg.id
  name                   = "polarion-prod"
  ipaddress              = "10.44.4.7"
  password               = data.azurerm_key_vault_secret.nv-polarion-prod.value
  location               = var.location
  resource_group_name    = var.resource_group_name
  subnet_id              = azurerm_subnet.nv_polarion_subnet.id
  vault_id               = data.azurerm_key_vault.nv-infra-core.id
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = var.vm_size
  managed_data_disk_size = var.managed_data_disk_size
}

data "azurerm_key_vault_secret" "nv-polarion-test" {
  name         = "nv-polarion-test"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

module "nv-polarion-test" {
  source                 = ".//modules/polarion-server"
  security_group_id      = azurerm_network_security_group.nv_polarion_nsg.id
  name                   = "polarion-test"
  ipaddress              = "10.44.4.8"
  password               = data.azurerm_key_vault_secret.nv-polarion-test.value
  location               = var.location
  resource_group_name    = var.resource_group_name
  subnet_id              = azurerm_subnet.nv_polarion_subnet.id
  vault_id               = data.azurerm_key_vault.nv-infra-core.id
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = var.vm_size
  managed_data_disk_size = var.managed_data_disk_size
}

data "azurerm_key_vault_secret" "nv-polarion-cordinator" {
  name         = "nv-polarion-cordinator"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

module "nv-polarion-cordinator" {
  source                 = ".//modules/polarion-server"
  security_group_id      = azurerm_network_security_group.nv_polarion_nsg.id
  name                   = "polarion-cord"
  ipaddress              = "10.44.4.9"
  password               = data.azurerm_key_vault_secret.nv-polarion-cordinator.value
  location               = var.location
  resource_group_name    = var.resource_group_name
  subnet_id              = azurerm_subnet.nv_polarion_subnet.id
  vault_id               = data.azurerm_key_vault.nv-infra-core.id
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = "Standard_B2ms"
  managed_data_disk_size = "10"
}