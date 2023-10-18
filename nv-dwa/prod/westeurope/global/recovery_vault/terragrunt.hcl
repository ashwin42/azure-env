terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.6.13"
  #source = "../../../../../../tf-mod-azure/recovery_vault/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  recovery_vault_name = "nv-dwa-infra-rv"
}

