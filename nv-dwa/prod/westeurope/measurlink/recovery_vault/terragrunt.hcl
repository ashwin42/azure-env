terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.10.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/recovery_vault/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  recovery_vault_name = "measurlink-dwa-rv"
}

