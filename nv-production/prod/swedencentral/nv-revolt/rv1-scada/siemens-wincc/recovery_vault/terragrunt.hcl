terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.7.39"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/recovery_vault/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix        = basename(get_terragrunt_dir())
  recovery_vault_name = "rv1-siemens-wincc-rv"
}

