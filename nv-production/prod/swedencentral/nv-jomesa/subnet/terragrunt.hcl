terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
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
      name                                          = "${include.root.locals.all_vars.project}-subnet1"
      netbox_subnet_name                            = "nv-jomesa-subnet"
      address_prefixes                              = ["10.64.2.32/27"]
      route_table_name                              = "nv-production-swc-default-rt"
      route_table_resource_group_name               = "nv-prod-swe-vnet-rg"
      service_endpoints                             = ["Microsoft.Sql"]
      private_link_service_network_policies_enabled = false
    },
  ]
}
