# Deploys Transit VPC and high availability pair of Transit Gateways
terraform {
  source = "git::git@github.com:northvolt/tf-mod-aviatrix.git//avx-transit-egress?ref=v0.1.9"
  # source = "${dirname(get_repo_root())}/tf-mod-aviatrix//avx-transit-egress"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rg" {
  config_path = "../../resource_group"
}

inputs = {
  cloud                  = "Azure"
  cidr                   = "100.64.6.0/24"
  region                 = "Sweden Central"
  account                = "azure-hub-dev"
  name                   = "swecen-${include.root.inputs.subscription_name}-avx-dev-tvnet" # Name of transit VPC 30 characters limit & only hyphens/underscores
  gw_name                = "swecen-${include.root.inputs.subscription_name}-avx-dev-tgw"   # Name of transit GW 50 character limit & only hyphens/underscores
  instance_size          = "Standard_B2ms"
  local_as_number        = "63915"
  enable_transit_firenet = true
  firewall_image         = "aviatrix"
  enable_segmentation    = true
  resource_group         = dependency.rg.outputs.resource_group_name
  lan_subnet             = "100.64.6.80/28"
  ha_lan_subet           = "100.64.6.128/28"
}
