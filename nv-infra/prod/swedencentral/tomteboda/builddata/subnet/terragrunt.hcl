terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.7"
  #source = "{dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
}

dependency "vnet" {
  config_path = "../../../nv-infra-swc-vnet/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  vnet_resource_group = "nv-gen-infra-swc-rg"
  default_route_table = "nv-gen-infra-swc-default-rt"
}

inputs = {
  vnet_name                = dependency.vnet.outputs.virtual_network.name
  vnet_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name

  subnets = [
    {
      name                                          = "${include.root.locals.all_vars.project}-subnet1"
      netbox_subnet_name                            = "Tomteboda - BuildData SQL"
      address_prefixes                              = ["10.64.32.192/28"]
      route_table_name                              = local.default_route_table
      route_table_resource_group_name               = local.vnet_resource_group
      service_endpoints                             = ["Microsoft.Sql"]
      private_link_service_network_policies_enabled = false
      delegation                                    = []
    },
  ]
}
