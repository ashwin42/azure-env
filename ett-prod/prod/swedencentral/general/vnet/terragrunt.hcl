terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = "${include.root.inputs.subscription_name}-general"
  netbox_vnet_name         = "${include.root.inputs.subscription_name}-swc-vnet"
  update_netbox            = true
  address_space            = ["10.64.128.0/19"]
  dns_servers              = []
  subnets = [
    {
      name               = "${include.root.inputs.subscription_name}-general_subnet1"
      netbox_subnet_name = "${include.root.inputs.subscription_name} general subnet 1"
      address_prefixes   = ["10.64.128.0/24"]
      update_netbox      = true
    },
  ]
}

