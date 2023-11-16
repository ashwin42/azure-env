terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/global/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = "lv-incore"
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name             = "lv-incore-subnet-10.46.0.128-28"
      address_prefixes = ["10.46.0.128/28"]
    },
  ]
}

