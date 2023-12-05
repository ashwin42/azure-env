terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "{dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
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
      netbox_subnet_name                            = "DWA - Siemens WCS - Servers/databases"
      address_prefixes                              = ["10.46.97.32/27"]
      route_table_name                              = "nv-dwa-we-default-rt"
      route_table_resource_group_name               = dependency.vnet.outputs.virtual_network.resource_group_name
      service_endpoints                             = ["Microsoft.Sql"]
      private_link_service_network_policies_enabled = false
      delegation                                    = []
    },
    {
      name                            = "${include.root.locals.all_vars.project}-web-app-inbound"
      netbox_subnet_name              = "DWA - Siemens WCS - web-app Inbound"
      address_prefixes                = ["10.46.97.64/28"]
      route_table_name                = "nv-dwa-we-default-rt"
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
    {
      name                            = "${include.root.locals.all_vars.project}-web-app-outbound"
      netbox_subnet_name              = "DWA - Siemens WCS - web-app outbound"
      address_prefixes                = ["10.46.97.80/28"]
      route_table_name                = "nv-dwa-we-default-rt"
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
