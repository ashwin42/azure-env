terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.9.3"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/global/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = "lv-incore"
  resource_group_name      = "lv-incore-rg"
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name             = "lv-incore-subnet-10.46.0.128-28"
      address_prefixes = ["10.46.0.128/28"]
      route_table_name = "lv-incore_vnet_default_rt"
    },
  ]

route_tables = [
    {
      name = "lv-incore_vnet_default_rt"
      routes = [
        {
          address_prefix         = "10.0.0.0/8"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.40.253.5"
        },
      ]
    }
  ]
}

