terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.3.0"
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
      name              = "nv-octoplant-10.46.1.8_29"
      address_prefixes  = ["10.46.1.8/29"]
      service_endpoints = ["Microsoft.Storage"]
    },
  ]
}

