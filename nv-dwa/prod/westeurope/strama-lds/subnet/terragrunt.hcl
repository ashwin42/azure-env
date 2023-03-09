terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.32"
  #source = "../../../../../../tf-mod-azure/vnet/"
}

dependency "vnet" {
  config_path = "../../global/vnet"
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
      name                                          = "${include.root.locals.all_vars.project}-subnet1"
      address_prefixes                              = ["10.46.97.96/28"]
      route_table_name                              = "nv-dwa-we-default-rt"
      route_table_resource_group_name               = dependency.vnet.outputs.virtual_network.resource_group_name
      service_endpoints                             = ["Microsoft.Sql"]
      private_link_service_network_policies_enabled = false
    },
  ]
}
