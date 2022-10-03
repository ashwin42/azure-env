terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=${include.root.locals.all_vars.tf_mod_azure_global_version}"
  #source = "../../../../../tf-mod-azure/global"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix          = include.root.locals.all_vars.subscription_name
  address_space         = ["10.46.32.0/21"]
  dns_servers           = include.root.locals.all_vars.dns_servers
  create_recovery_vault = false
  resource_group_name   = include.root.locals.all_vars.subscription_name
  vnet_name             = "${include.root.locals.all_vars.subscription_name}_vnet"
  subnets = [
    {
      name                 = "databases"
      address_prefixes     = ["10.46.32.0/27"]
      service_endpoints    = ["Microsoft.Sql"]
      enforce_private_link = true
      nsg_name             = "${include.root.locals.all_vars.subscription_name}_vnet"
      nsg_rules = [
        {
          name                  = "Labs_MFA_VPN"
          priority              = "200"
          direction             = "Inbound"
          source_address_prefix = include.root.locals.all_vars.vpn_subnet_labs
          access                = "Allow"
          description           = "Allow connections from Labs MFA VPN clients"
        },
      ]
    },
  ]
  peerings = [
    {
      name                  = "erp_prod_to_nv-hub",
      vnet_id               = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit = false
    },
  ]
}

