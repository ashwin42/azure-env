terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=${include.root.locals.all_vars.tf_mod_azure_global_version}"
  #source = "../../../../../../tf-mod-azure/global/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = "asrs-nv1-prod"
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name                 = "asrs-nv1-prod-subnet-10.46.0.0-27"
      address_prefixes     = ["10.46.0.0/27"]
      service_endpoints    = ["Microsoft.Sql"]
      enforce_private_link = true
      delegation           = []
    },
    {
      name                 = "asrs-nv1-prod-subnet-10.46.0.32-28"
      address_prefixes     = ["10.46.0.32/28"]
      service_endpoints    = []
      enforce_private_link = false
      delegation = [
        {
          name                       = "Microsoft.Web.serverFarms",
          service_delegation_name    = "Microsoft.Web/serverFarms",
          service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        },
      ]
    },
    {
      name                 = "asrs-nv1-prod-subnet-10.46.0.48-28"
      address_prefixes     = ["10.46.0.48/28"]
      service_endpoints    = []
      enforce_private_link = false
      delegation = [
        {
          name                       = "Microsoft.Web.serverFarms",
          service_delegation_name    = "Microsoft.Web/serverFarms",
          service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        },
      ]
    },
    {
      name                 = "asrs-nv1-prod-subnet-10.46.0.80-28"
      address_prefixes     = ["10.46.0.80/28"]
      service_endpoints    = []
      enforce_private_link = false
      delegation = [
        {
          name                       = "Microsoft.Web.serverFarms",
          service_delegation_name    = "Microsoft.Web/serverFarms",
          service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        },
      ]
    },
    {
      name                 = "asrs-nv1-prod-subnet-10.46.0.96-28"
      address_prefixes     = ["10.46.0.96/28"]
      service_endpoints    = []
      enforce_private_link = false
      delegation = [
        {
          name                       = "Microsoft.Web.serverFarms",
          service_delegation_name    = "Microsoft.Web/serverFarms",
          service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        },
      ]
    },
    {
      name                 = "asrs-nv1-prod-subnet-10.46.0.112-28"
      address_prefixes     = ["10.46.0.112/28"]
      service_endpoints    = []
      enforce_private_link = false
      delegation = [
        {
          name                       = "Microsoft.Web.serverFarms",
          service_delegation_name    = "Microsoft.Web/serverFarms",
          service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        },
      ]
    },
  ]
}

