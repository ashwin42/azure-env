terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/"
}

dependency "vnet" {
  config_path = "../../../../nv-infra-vnet/"
}


include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = dependency.vnet.outputs.virtual_network.name
  vnet_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name

  subnets = [
    {
      name             = "revolt-scada-subnet1"
      address_prefixes = ["10.46.2.64/28"]
    },
  ]
}

