# Overview
This module installs a TIA server
* Windows Server 2016
* TIA MU Portal 15

# Usage

```hcl
data "azurerm_key_vault_secret" "tia_password" {
  name      = "tia-<CUSTOMER>-nvadmin"
  vault_uri = "${data.azurerm_key_vault.nv_core.vault_uri}"
}

module "tia_<CUSTOMER>" {
  source              = "../modules/tia-server"
  name                = "<CUSTOMER>"
  ipaddress           = "<PRIVATE IP>"
  password            = "${data.azurerm_key_vault_secret.tia_password.value}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${local.nv_automation_1}"
  vault_id            = "${data.azurerm_key_vault.nv_core.id}"
  recovery_vault_name = "${data.terraform_remote_state.nv-shared.recovery_services.recovery_vault_name}"
  backup_policy_id    = "${data.terraform_remote_state.nv-shared.recovery_services.protection_policy_daily_id}"
}

```

You should manually create a secret for the nvadmin user in the nv-core vault before deploying the machine.