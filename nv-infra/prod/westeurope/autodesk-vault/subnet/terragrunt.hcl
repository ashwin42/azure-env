terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.22"
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
      name             = "autodesk-vault-subnet-10.46.1.0_29"
      address_prefixes = ["10.46.1.0/29"]
    },
  ]
}

