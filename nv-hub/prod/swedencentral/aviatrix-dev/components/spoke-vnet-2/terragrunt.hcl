terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.3.5"
  # source = "../../../../../../../tf-mod-azure//vnet"
}

dependency "rg" {
  config_path = "../../resource_group"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "${include.root.inputs.location}-${include.root.inputs.subscription_name}.avx.dev-vnet-2"
  address_space            = ["100.64.3.0/24"]
  vnet_resource_group_name = dependency.rg.outputs.resource_group_name
  # bgp_community = "" what should this be?
  subnets = [
    {
      name             = "${include.root.inputs.location}-${include.root.inputs.subscription_name}.avx.dev-subnet-2.pub-a"
      address_prefixes = ["100.64.3.0/26"]
    },
    {
      name             = "${include.root.inputs.location}-${include.root.inputs.subscription_name}.avx.dev-subnet-2.pub-b"
      address_prefixes = ["100.64.3.64/26"]
    },
  ]
}