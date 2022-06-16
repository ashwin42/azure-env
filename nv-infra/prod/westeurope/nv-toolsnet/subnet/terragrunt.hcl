terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.3.0"
  #source = "../../../../../../tf-mod-azure/vnet/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name             = "nv-toolsnet-subnet-10.46.1.16_28"
      address_prefixes = ["10.46.1.16/28"]
    },
  ]
}

