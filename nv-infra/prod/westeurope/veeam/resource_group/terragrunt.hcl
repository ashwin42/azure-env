terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.9.2"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

