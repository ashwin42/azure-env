terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  resource_group_name      = "nv-apis-iq-rg"
  dns_servers              = []
  subnets = [
    {
      name               = "nv-apis-iq-subnet-10.46.1.48_28"
      netbox_subnet_name = "nv-apis-iq subnet"
      address_prefixes   = ["10.46.1.48/28"]
      route_table_name   = "nv-apis-iq_default-rt"
    },
  ]

  route_tables = [
    {
      name = "nv-apis-iq_default-rt"
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

