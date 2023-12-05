terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.9.2"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

