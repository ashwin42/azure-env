terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "global"
  vnet_resource_group_name = "global-rg"
  subnets = [
    {
      name             = "octoplant-dwa-10.46.97.0_29"
      address_prefixes = ["10.46.97.0/29"]
      route_table_name = "octoplant-dwa_default-rt"
    },
  ]
  route_tables = [
    {
      name = "octoplant-dwa_default-rt"
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