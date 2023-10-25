terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "nv-gen-infra-swc-vnet"
  vnet_resource_group_name = "nv-gen-infra-swc-rg"
  resource_group_name      = "nv-asrs-rg"
  dns_servers              = []
  subnets = [
    {
      name               = "nv-asrs-monitoring-subnet-10.67.1.0_28"
      netbox_subnet_name = "nv-asrs-monitoring subnet"
      address_prefixes   = ["10.67.1.0/28"]
    },
  ]
}

