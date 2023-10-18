terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.12"
  #source = "../../../../../../tf-mod-azure/vnet/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "nv-prod-swe-vnet"
  vnet_resource_group_name = "nv-prod-swe-vnet-rg"
  subnets = [
    {
      name                            = "nv-lims-subnet-10.64.1.32_27"
      address_prefixes                = ["10.64.1.32/27"]
      route_table_name                = "nv-production-swc-default-rt"
      service_endpoints               = ["Microsoft.Sql", "Microsoft.Storage"]
      route_table_resource_group_name = "nv-prod-swe-vnet-rg"
    },
  ]
}
