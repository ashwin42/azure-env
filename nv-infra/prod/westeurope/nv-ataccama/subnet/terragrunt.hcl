terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.22"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  resource_group_name      = "nv-ataccama-rg"
  subnets = [
    {
      name             = "nv-ataccama-subnet"
      address_prefixes = ["10.46.2.16/28"]
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
