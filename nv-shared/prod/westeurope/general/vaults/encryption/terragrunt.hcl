terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//keyvault?ref=v0.6.10"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/keyvault//"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                        = include.root.inputs.encryption_key_vault_name
  enabled_for_disk_encryption = true
}

