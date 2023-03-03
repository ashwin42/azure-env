terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.39"
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
      name                                          = "revolt-wcs-subnet-01"
      address_prefixes                              = ["10.46.2.80/28"]
      service_endpoints                             = ["Microsoft.Sql"]
      private_link_service_network_policies_enabled = false
      delegation                                    = []
    },
    {
      name             = "revolt-wcs-web-app-01"
      address_prefixes = ["10.46.2.96/28"]
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

