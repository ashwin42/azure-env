terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.20"
  #source = "../../../../../../tf-mod-azure/vnet/"
}

dependency "vnet" {
  config_path = "../../nv-prod-swe-vnet/vnet"
}


include {
  path = find_in_parent_folders()
}

inputs = {
  vnet_name                = dependency.vnet.outputs.virtual_network.name
  vnet_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name

  subnets = [
    {
      name                            = "congree-subnet"
      address_prefixes                = ["10.64.1.128/29"]
      route_table_name                = "nv-production-swc-default-rt"
      route_table_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name
    },
  ]
}
