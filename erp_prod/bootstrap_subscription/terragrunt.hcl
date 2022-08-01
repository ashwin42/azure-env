terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//bootstrap_subscription?ref=v0.5.3"
  #source = "../../../tf-mod-azure/bootstrap_subscription/"
}

include "account_vars" {
  path   = "../account.hcl"
  expose = true
}

inputs = {
  subscription_id      = include.account_vars.locals.subscription_id
  name                 = include.account_vars.locals.subscription_name
  storage_account_name = include.account_vars.locals.remote_state_azurerm_storage_account_name
  rg_name              = include.account_vars.locals.remote_state_azurerm_resource_group_name
}
