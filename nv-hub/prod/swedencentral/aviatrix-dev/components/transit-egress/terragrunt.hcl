terraform {
  source = "git::git@github.com:northvolt/tf-mod-aviatrix.git//avtx-transit-egress?ref=v0.0.3"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  cloud                  = "Azure"
  cidr                   = "100.64.6.0/24"
  region                 = "Sweden Central"
  account                = "azure-hub-dev"
  name                   = "${include.root.inputs.location}-${include.root.inputs.subscription_name}-avx-tvnet" # Name of transit VPC 30 characters limit & only hyphens/underscores
  gw_name                = "${include.root.inputs.location}-${include.root.inputs.subscription_name}-avx-tgw"   # Name of transit GW 50 character limit & only hyphens/underscores
  instance_size          = "Fsv2"
  local_as_number        = "63910"
  enable_transit_firenet = true
  firewall_image         = "Aviatrix"
  enable_segmentation    = true
}