terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//management_group?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/management_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                    = "nv_root"
  display_name            = "NV Root"
  parent_management_group = "Tenant Root Group"
}

