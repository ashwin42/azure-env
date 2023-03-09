terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.7.31"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vnet_name                = "core_vnet"
  vnet_resource_group_name = "core_network"

  network_security_groups = [
    {
      name                = "aadds-nsg"
      resource_group_name = "core_utils"
      rules = [
        {
          name                       = "AllowSyncWithAzureAD"
          priority                   = 101
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "AzureActiveDirectoryDomainServices"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowRD"
          priority                   = 201
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "3389"
          source_address_prefix      = "CorpNetSaw"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowPSRemoting"
          priority                   = 301
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "5986"
          source_address_prefix      = "AzureActiveDirectoryDomainServices"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowNvCoreVnet"
          priority                   = 311
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "10.101.0.0/16"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowLabXVnet"
          priority                   = 321
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "10.44.2.0/26"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowLDAPS"
          priority                   = 401
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "636"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowTrafficToRDSLICSRV"
          priority                   = 410
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "10.0.0.0/8"
          destination_address_prefix = "10.40.250.6"
          description                = "deleteme-20221124"
        },
        {
          name                       = "AllowNvCoreVnetOutBound"
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "10.101.0.0/16"
        },
      ]
    },
  ]

  subnets = [
    {
      name                        = "nv-domain-services"
      address_prefixes            = ["10.40.250.0/24"]
      route_table_name            = "nv-hub-we-default-rt"
      network_security_group_name = "aadds-nsg"
    },
  ]
}

