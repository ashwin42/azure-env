terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.61"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  resource_group_name      = "nv-apis-iq-rg"
  dns_servers              = []
  subnets = [
    {
      name             = "nv-apis-iq-subnet-10.46.1.48_28"
      address_prefixes = ["10.46.1.48/28"]
    },
  ]
}

