terraform {
  source = "git::git@github.com:northvolt/tf-mod-aviatrix.git//avx-transit-egress?ref=v0.1.9"
  # source = "../../../../../../../tf-mod-aviatrix/avx-transit-egress"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  cloud                  = "Azure"
  cidr                   = "100.64.12.0/24"
  region                 = "West Europe"
  account                = "NV-Hub"
  name                   = "${include.root.inputs.location}-${include.root.inputs.subscription_name}-avx-tvpc"
  gw_name                = "${include.root.inputs.location}-${include.root.inputs.subscription_name}-avx-tgw"
  instance_size          = "Standard_D3_v2"
  resource_group         = include.root.inputs.resource_group_name
  local_as_number        = "63910"
  enable_transit_firenet = true
  firewall_image         = "aviatrix"
  enable_segmentation    = true
  lan_subnet             = "100.64.12.80/28"
  ha_lan_subnet          = "100.64.12.128/28"
}

