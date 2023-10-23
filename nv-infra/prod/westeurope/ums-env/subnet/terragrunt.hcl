terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = ""
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  resource_group_name      = "ums-env-rg"
  subnets = [
    {
      name               = "ums-env-subnet-10.46.0.144_28"
      netbox_subnet_name = "ums-env-subnet"
      address_prefixes   = ["10.46.0.144/28"]
    },
  ]
}

