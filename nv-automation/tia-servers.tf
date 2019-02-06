# Template to update the image
# module "tia-template" {
#   source              = "../modules/tia-server"
#   name                = "template"
#   ipaddress           = "10.101.2.245"
#   password            = "xq2!%5N&Vkz6YiaT"
#   location            = "${var.location}"
#   resource_group_name = "${var.resource_group_name}"
#   subnet_id           = "${local.nv_automation_1}"
#   #vault_id            = "${data.azurerm_key_vault.nv_core.id}"
#   recovery_vault_name = "${data.terraform_remote_state.nv-shared.recovery_services.recovery_vault_name}"
#   backup_policy_id    = "${data.terraform_remote_state.nv-shared.recovery_services.protection_policy_daily_id}"
# }

# -- Zeppelin --
data "azurerm_key_vault_secret" "tia_zeppelin" {
  name      = "tia-zeppelin-nvadmin"
  vault_uri = "${data.azurerm_key_vault.nv_core.vault_uri}"
}

module "tia_zeppelin" {
  source              = "../modules/tia-server"
  name                = "zeppelin"
  ipaddress           = "10.101.2.201"
  password            = "${data.azurerm_key_vault_secret.tia_zeppelin.value}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${local.nv_automation_1}"
  vault_id            = "${data.azurerm_key_vault.nv_core.id}"
  recovery_vault_name = "${data.terraform_remote_state.nv-shared.recovery_services.recovery_vault_name}"
  backup_policy_id    = "${data.terraform_remote_state.nv-shared.recovery_services.protection_policy_daily_id}"
}
