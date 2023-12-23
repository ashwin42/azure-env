terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.10.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/resource_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
}

