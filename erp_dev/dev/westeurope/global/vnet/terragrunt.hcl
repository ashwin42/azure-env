terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = include.root.locals.all_vars.setup_prefix
  netbox_vnet_name         = "erp_dev vnet"
  address_space            = ["10.46.44.0/22"]
  dns_servers              = []
  subnets = [
    {
      name               = "general_subnet1"
      netbox_subnet_name = "erp_dev: general_subnet1"
      address_prefixes   = ["10.46.44.0/27"]
    },
  ]
}

