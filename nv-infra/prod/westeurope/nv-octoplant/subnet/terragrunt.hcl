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
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name               = "nv-octoplant-10.46.1.8_29"
      netbox_subnet_name = "nv-octoplant"
      address_prefixes   = ["10.46.1.8/29"]
      service_endpoints  = ["Microsoft.Storage"]
      route_table_name   = "nv-gen-infra-vnet-default-rt"
    },
  ]
}
