terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//dns?ref=v0.9.8"
  #source = "../../../../../../tf-mod-azure//dns/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  dns_zones = [
    {
      name                = basename(get_terragrunt_dir())
      resource_group_name = "nv_infra"
    }
  ]
}

