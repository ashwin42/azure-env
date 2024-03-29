terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.6.13"
  #source = "../../../../../../tf-mod-azure/resource_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name = include.root.inputs.remote_state_azurerm_resource_group_name
  location            = "swedencentral"
  lock_resources      = false
}

