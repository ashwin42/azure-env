terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  #setup_prefix             = "asrs-nv1-prod"
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name                                      = "asrs-nv1-prod-subnet-10.46.0.0-27"
      address_prefixes                          = ["10.46.0.0/27"]
      service_endpoints                         = ["Microsoft.Sql"]
      route_table_name                          = "nv-gen-infra-vnet-default-rt"
      private_endpoint_network_policies_enabled = false
    },
    {
      name             = "asrs-nv1-prod-subnet-10.46.0.32-28"
      address_prefixes = ["10.46.0.32/28"]
      route_table_name = "nv-gen-infra-vnet-default-rt"
      delegation = [
        {
          name = "Microsoft.Web.serverFarms",
          service_delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        },
      ]
    },
    {
      name             = "asrs-nv1-prod-subnet-10.46.0.48-28"
      address_prefixes = ["10.46.0.48/28"]
      route_table_name = "nv-gen-infra-vnet-default-rt"
      delegation = [
        {
          name = "Microsoft.Web.serverFarms",
          service_delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        },
      ]
    },
    {
      name             = "asrs-nv1-prod-subnet-10.46.0.80-28"
      address_prefixes = ["10.46.0.80/28"]
      route_table_name = "nv-gen-infra-vnet-default-rt"
      delegation = [
        {
          name = "Microsoft.Web.serverFarms",
          service_delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        },
      ]
    },
    {
      name             = "asrs-nv1-prod-subnet-10.46.0.96-28"
      address_prefixes = ["10.46.0.96/28"]
      route_table_name = "nv-gen-infra-vnet-default-rt"
      delegation = [
        {
          name = "Microsoft.Web.serverFarms",
          service_delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        },
      ]
    },
    {
      name             = "asrs-nv1-prod-subnet-10.46.0.112-28"
      address_prefixes = ["10.46.0.112/28"]
      route_table_name = "nv-gen-infra-vnet-default-rt"
      delegation = [
        {
          name = "Microsoft.Web.serverFarms",
          service_delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        },
      ]
    },
    {
      name             = "cathode2-web-app-subnet"
      address_prefixes = ["10.46.2.0/29"]
      route_table_name = "nv-gen-infra-vnet-default-rt"
      delegation = [
        {
          name = "Microsoft.Web.serverFarms",
          service_delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        },
      ]
    },
    {
      name             = "anode2-web-app-subnet"
      address_prefixes = ["10.46.2.8/29"]
      route_table_name = "nv-gen-infra-vnet-default-rt"
      delegation = [
        {
          name = "Microsoft.Web.serverFarms",
          service_delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        },
      ]
    },
    {
      name             = "siemens-mgmt-subnet"
      address_prefixes = ["10.46.2.96/29"]
      route_table_name = "nv-gen-infra-vnet-default-rt"
    }
  ]
}

