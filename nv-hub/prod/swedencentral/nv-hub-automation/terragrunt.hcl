terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//automation?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/automation"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                = "nv-hub-automation"
  location            = "westeurope"
  resource_group_name = "core_utils"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109037 IT Common - AB"
    cost-center   = "109037064 IT Common - AB"
  }
}

