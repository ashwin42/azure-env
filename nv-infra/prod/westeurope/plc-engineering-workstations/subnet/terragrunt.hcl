terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.7"
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
      name               = "nv-plc-ews-10.46.1.32_28"
      netbox_subnet_name = "nv-plc-ews: PLC Engineering Workstations"
      address_prefixes   = ["10.46.1.32/28"]
      route_table_name   = "nv-plc-ews-subnet_default-rt"
    },
  ]
  route_tables = [
    {
      name = "nv-plc-ews-subnet_default-rt"
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

