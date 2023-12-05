terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = ""
  vnet_name                = "nv-prod-swe-vnet"
  vnet_resource_group_name = "nv-prod-swe-vnet-rg"
  subnets = [
    {
      name                            = "nv-lims-subnet-10.64.1.32_27"
      netbox_subnet_name              = "nv-lims-subnet"
      address_prefixes                = ["10.64.1.32/27"]
      route_table_name                = "nv-production-swc-default-rt"
      service_endpoints               = ["Microsoft.Sql", "Microsoft.Storage"]
      route_table_resource_group_name = "nv-prod-swe-vnet-rg"
    },
  ]
}
