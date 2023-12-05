terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

dependency "vnet" {
  config_path = "../../../../nv-prod-swe-vnet/vnet/"
}


include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = ""
  vnet_name                = dependency.vnet.outputs.virtual_network.name
  vnet_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name

  subnets = [
    {
      name                                          = "revolt-wcs-subnet-01"
      address_prefixes                              = ["10.64.1.224/28"]
      route_table_name                              = "nv-production-swc-default-rt"
      route_table_resource_group_name               = dependency.vnet.outputs.virtual_network.resource_group_name
      service_endpoints                             = ["Microsoft.Sql"]
      private_link_service_network_policies_enabled = false
      delegation                                    = []
    },
    {
      name                            = "revolt-wcs-web-app-01"
      address_prefixes                = ["10.64.1.240/28"]
      route_table_name                = "nv-production-swc-default-rt"
      route_table_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name
      delegation = [
        {
          name = "Microsoft.Web.serverFarms",
          service_delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        },
      ]
    },
  ]
}

