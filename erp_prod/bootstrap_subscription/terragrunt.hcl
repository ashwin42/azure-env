terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//bootstrap_subscription?ref=v0.5.3"
  #source = "../../../tf-mod-azure/bootstrap_subscription/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  storage_account_name = include.root.locals.all_vars.remote_state_azurerm_storage_account_name
  resource_group_name  = include.root.locals.all_vars.remote_state_azurerm_resource_group_name
}
