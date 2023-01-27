# Deploys Transit VPC and high availability pair of Transit Gateways
terraform {
  source = "git::git@github.com:northvolt/tf-mod-aviatrix.git//avtx-transit-egress?ref=v0.0.15"
  # source = "../../../../../../../tf-mod-aviatrix/avtx-transit-egress"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rg" {
  config_path = "../../resource_group"
}

inputs = {
  cloud  = "Azure"
  cidr   = "100.64.11.0/24"
  region = "Sweden Central"

  # Aviatrix Controller account name
  account = "NV-Hub"

  # Name of transit VNET 30 characters limit & only hyphens/underscores
  name = "${include.root.locals.all_vars.location}-${include.root.locals.all_vars.subscription_name}-avx-tvpc"

  # Name of transit GW 50 character limit & only hyphens/underscores
  gw_name       = "${include.root.locals.all_vars.location}-${include.root.locals.all_vars.subscription_name}-avx-tgw"

  instance_size = "Standard_D3_v2"
  resource_group = dependency.rg.outputs.resource_group_name

  # ASN (hampusrosvall): Just picked random one.
  local_as_number = "65529"

  enable_transit_firenet = true
  firewall_image         = "aviatrix"
  enable_segmentation    = true

  lan_subnet    = "100.64.11.80/28"
  ha_lan_subnet = "100.64.11.128/28"
}
