terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.6.13"
  #source = "../../../../../tf-mod-azure/vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = include.root.locals.all_vars.setup_prefix
  address_space            = ["10.46.44.0/22"]
  dns_servers              = []
  subnets = [
    {
      name             = "general_subnet1"
      address_prefixes = ["10.46.44.0/27"]
    },
  ]
}

