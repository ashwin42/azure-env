terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

dependency "vnet" {
  config_path = "../../nv-infra-vnet/"
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
      name             = "ms-ondemand-assessments-subnet"
      address_prefixes = ["10.46.2.64/28"]
    },
  ]
}

