terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name   = "nv-gen-infra-swc-rg"
  create_resource_group = true
  name                  = "nv-gen-infra-swc-vnet"
  netbox_description    = "nv-gen-infra-swc vnet"
  address_space         = ["10.64.32.0/19"]

  subnets = [
    {
      name               = "nv-gen-infra-swc-subnet"
      netbox_subnet_name = "nv-gen-infra-swc general subnet"
      address_prefixes   = ["10.64.32.0/25"]
    },
  ]
}

