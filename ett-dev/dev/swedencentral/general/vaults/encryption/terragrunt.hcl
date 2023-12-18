terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//keyvault?ref=v0.9.3"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//keyvault//"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = include.root.inputs.encryption_key_vault_name
}

inputs = {
  name                        = local.name
  enabled_for_disk_encryption = true
}

