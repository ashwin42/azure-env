terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_resource_group_name = include.root.locals.all_vars.resource_group_name
  vnet_name                = "westus2.nv-cuberg.general-vnet"
  address_space            = ["10.66.0.0/22"]
  dns_servers              = []
  subnets = [
    {
      name             = "westus2.nv-cuberg.general-subnet"
      address_prefixes = ["10.66.0.0/25"]
    },
  ]
}


