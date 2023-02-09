terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.26"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/tf-mod-azure/vnet/"
}

dependency "vnet" {
  config_path = "../../nv-infra-vnet"
}


include {
  path = find_in_parent_folders()
}

inputs = {
  vnet_name                = dependency.vnet.outputs.virtual_network.name
  vnet_resource_group_name = dependency.vnet.outputs.virtual_network.resource_group_name
  resource_group_name      = "nv-labs-qc"

  subnets = [
    {
      name             = "nv-labs-qc-subnet-10.46.2.32_28"
      address_prefixes = ["10.46.2.32/28"]
      service_endpoints = [
        "Microsoft.Sql",
        "Microsoft.Storage",
      ]
      nsg_rules = [
        {
          name                  = "Labs_MFA_VPN"
          priority              = "200"
          direction             = "Inbound"
          source_address_prefix = "10.16.8.0/23"
          protocol              = "Tcp"
          access                = "Allow"
          description           = "Allow connections from Labs MFA VPN clients"
        },
        {
          name                  = "Ett_MFA_VPN"
          priority              = "201"
          direction             = "Inbound"
          source_address_prefix = "10.240.0.0/21"
          protocol              = "Tcp"
          access                = "Allow"
          description           = "Allow connections from Ett MFA VPN clients"
        },
      ]
    },
  ]
}

