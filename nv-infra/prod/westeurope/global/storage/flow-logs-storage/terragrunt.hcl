terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.9.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name = "nvinfraflowlogweu"
}
