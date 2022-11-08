terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.8"
  #source = "../../../../../../tf-mod-azure/vnet/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vnet_name                = "nv-prod-swe-vnet"
  vnet_resource_group_name = "nv-prod-swe-vnet-rg"
  subnets = [
    {
      name             = "nv-honey-subnet-10.64.1.0_28"
      address_prefixes = ["10.64.1.0/28"]
    },
  ]
}
