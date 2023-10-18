terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.8.6"
  #source = "../../../../../../tf-mod-azure/resource_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name = "erp-dev-tfstate-rg"
  lock_resources      = false
}

