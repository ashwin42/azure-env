terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

dependency "vnet" {
  config_path = "../../nv-prod-swe-vnet/vnet"
}


include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = ""
  vnet_name                = dependency.vnet.outputs.virtual_network.name
  vnet_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name
  network_security_groups = [
    {
      name = "congree-sql-nsg"
    },
  ]

  subnets = [
    {
      name                            = "congree-subnet"
      address_prefixes                = ["10.64.1.128/29"]
      route_table_name                = "nv-production-swc-default-rt"
      route_table_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name
    },
    {
      name                            = "congree-subnet-sql"
      address_prefixes                = ["10.64.2.0/28"]
      route_table_name                = "nv-production-swc-default-rt"
      route_table_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name
      network_security_group_name     = "congree-sql-nsg"
      delegation = [
        {
          name = "Microsoft.Sql.managedInstances",
          service_delegation = {
            name = "Microsoft.Sql/managedInstances"
            actions = [
              "Microsoft.Network/virtualNetworks/subnets/join/action",
              "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
              "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
            ]
          }
        }
      ]
    },
  ]
}
