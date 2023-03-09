terraform {
  source = "github.com/terraform-aviatrix-modules/terraform-aviatrix-mc-spoke.git//?ref=v1.2.2"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "spoke" {
  config_path = "../spoke-vnet-1"
}

dependency "rg" {
  config_path = "../../resource_group"
}

inputs = {
  cloud            = "Azure"
  name             = "${include.root.inputs.location}-${include.root.inputs.subscription_name}-dev-spoke-gw-1"
  region           = "Sweden Central"
  account          = "azure-hub-dev"
  transit_gw       = "swedencentral-nv-hub-avx-tgw"
  use_existing_vpc = true
  # network_domain  = "green"
  vpc_id           = "${dependency.spoke.outputs.virtual_network.name}:${dependency.rg.outputs.resource_group_name}"
  gw_subnet        = dependency.spoke.outputs.subnet["${include.root.inputs.location}-${include.root.inputs.subscription_name}.avx.dev-subnet-1.pub-a"]["address_prefixes"][0] # subnet-a
  hagw_subnet      = dependency.spoke.outputs.subnet["${include.root.inputs.location}-${include.root.inputs.subscription_name}.avx.dev-subnet-1.pub-b"]["address_prefixes"][0] # subnet-b
  resource_group   = dependency.rg.outputs.resource_group_name
}
