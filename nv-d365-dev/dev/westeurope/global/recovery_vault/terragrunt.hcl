terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.7.8"
  #source = "../../../../../../tf-mod-azure/recovery_vault/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  recovery_vault_name = "nv-d365-dev-rv"
  resource_group_name = "nv-d365-dev-core"
}

