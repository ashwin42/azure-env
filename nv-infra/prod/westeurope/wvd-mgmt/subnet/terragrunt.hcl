terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.63"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name             = include.root.inputs.project_name
      address_prefixes = ["10.46.2.80/28"]
    },
  ]
}

