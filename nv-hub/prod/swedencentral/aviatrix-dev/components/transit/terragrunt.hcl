# Deploys Transit VPC and high availability pair of Transit Gateways
terraform {
  source = "github.com/terraform-aviatrix-modules/terraform-aviatrix-mc-transit.git//?ref=v2.1.3"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rg" {
    config_path = "../../resource_group"
}

inputs = {
  cloud               = "Azure"
  cidr                = "100.64.6.0/24"
  region              = "Sweden Central"
  account             = "azure-hub-dev"
  name                = "${include.root.inputs.location}-dev-avx-tvnet" # Name of transit VPC 30 characters limit & only hyphens/underscores
  gw_name             = "${include.root.inputs.location}-${include.root.inputs.subscription_name}-dev-avx-tgw"   # Name of transit GW 50 character limit & only hyphens/underscores
  instance_size       = "Standard_B1ms"
  local_as_number     = "63910"
  enable_segmentation = true
  resource_group      = dependency.rg.outputs.resource_group_name
}
