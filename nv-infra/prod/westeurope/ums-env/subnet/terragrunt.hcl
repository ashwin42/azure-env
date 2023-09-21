terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.8.4"
  #source = "../../../../../../tf-mod-azure/vnet/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  resource_group_name      = "ums-env-rg"
  subnets = [
    {
      name             = "ums-env-subnet-10.46.0.144_28"
      address_prefixes = ["10.46.0.144/28"]
    },
  ]
}

