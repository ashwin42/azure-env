terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//automation?ref=v0.7.26"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/automation"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                = "nv-hub-automation"
  location            = "westeurope"
  resource_group_name = "core_utils"
}

