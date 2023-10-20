terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
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
      name                            = "nv-wwt-subnet-10.64.1.16_28"
      netbox_subnet_name              = "nv-wwt-subnet"
      address_prefixes                = ["10.64.1.16/28"]
      route_table_name                = "nv-production-swc-default-rt"
      route_table_resource_group_name = "nv-prod-swe-vnet-rg"
    },
  ]
}
