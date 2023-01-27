# Deploys Transit VPC and high availability pair of Transit Gateways
terraform {
  source = "git::git@github.com:northvolt/tf-mod-aviatrix.git//avtx-transit-egress?ref=v0.0.15"
  # source = "../../../../../../../tf-mod-aviatrix/avtx-transit-egress"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  cloud  = "Azure"
  cidr   = "100.64.12.0/24"
  region = "West Europe"

  # Aviatrix Controller account name
  account = "NV-Hub"

  # Name of transit VNET 30 characters limit & only hyphens/underscores
  name = "${include.root.locals.all_vars.location}-${include.root.locals.all_vars.subscription_name}-avx-tvpc"

  # Name of transit GW 50 character limit & only hyphens/underscores
  gw_name = "${include.root.locals.all_vars.location}-${include.root.locals.all_vars.subscription_name}-avx-tgw"

  instance_size  = "Standard_D3_v2"
  resource_group = include.root.locals.all_vars.resource_group_name

  # ASN (hampusrosvall): Just picked random one.
  local_as_number = "65539"

  enable_transit_firenet = true
  firewall_image         = "aviatrix"
  enable_segmentation    = true

  lan_subnet    = "100.64.12.80/28"
  ha_lan_subnet = "100.64.12.128/28"
}
