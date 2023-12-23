terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
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
      address_prefixes                              = ["10.46.97.128/28"]
      route_table_name                              = "nv-dwa-we-default-rt"
      route_table_resource_group_name               = dependency.vnet.outputs.virtual_network.resource_group_name
      private_link_service_network_policies_enabled = false
      delegation                                    = []
    },
  ]
}
