terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.2.36"
  #source = "../../../../../../tf-mod-azure/vnet/"
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
      name             = "powerbi-client-subnet-10.46.0.176_28"
      address_prefixes = ["10.46.0.176/28"]
    },
  ]
}

