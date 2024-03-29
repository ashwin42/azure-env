# Deploys Transit VPC and high availability pair of Transit Gateways
terraform {
  source = "git::git@github.com:northvolt/tf-mod-aviatrix.git//avx-transit-egress?ref=v0.1.9"
  # source = "../../../../../../../tf-mod-aviatrix/avx-transit-egress"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rg" {
  config_path = "../../resource_group"
}

inputs = {
  cloud                    = "Azure"
  cidr                     = "100.64.38.0/23"
  region                   = "Sweden Central"
  account                  = "NV-Hub"
  name                     = "${include.root.inputs.location}-${include.root.inputs.subscription_name}-avx-tvpc"
  gw_name                  = "${include.root.inputs.location}-${include.root.inputs.subscription_name}-avx-tgw"
  instance_size            = "Standard_D4_v2"
  resource_group           = dependency.rg.outputs.resource_group_name
  local_as_number          = "64602"
  enable_transit_firenet   = true
  firewall_image           = "aviatrix"
  enable_segmentation      = true
  insane_mode              = true
  enable_bgp_over_lan      = true
  lan_subnet               = "100.64.38.80/28"
  ha_lan_subnet            = "100.64.38.144/28"
  bgp_lan_interfaces_count = 1
}
