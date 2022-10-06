terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.6.10"
  #source = "../../../tf-mod-azure/storage/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  name                 = include.root.inputs.remote_state_azurerm_storage_account_name
  resource_group_name  = include.root.inputs.remote_state_azurerm_resource_group_name
  containers_list = [
    { name = include.root.inputs.remote_state_azurerm_container_name, access_type = "private" }
  ]
}
