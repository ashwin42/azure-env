terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.6.10"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../../global/vnet/"
}

dependency "wvd" {
  config_path = "../${replace("${local.name}", "vm", "wvd")}"
}

locals {
  name   = basename(get_terragrunt_dir())
  common = read_terragrunt_config(find_in_parent_folders("common-pnl-vms.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    token          = dependency.wvd.outputs.token
    host_pool_name = dependency.wvd.outputs.host_pool.name
    network_interfaces = [
      {
        name = "${local.name}-nic"
        ip_configuration = [
          {
            private_ip_address            = "10.46.40.9"
            subnet_id                     = dependency.vnet.outputs.subnet.subnet1.id
            private_ip_address_allocation = "Static"
            ipconfig_name                 = "ipconfig"
          }
        ]
      }
    ]

    custom_rules = [
      {
        name                   = "Labs_MFA_VPN"
        priority               = "200"
        direction              = "Inbound"
        source_address_prefix  = "10.16.8.0/23"
        protocol               = "*"
        destination_port_range = "3389, 8735"
        access                 = "Allow"
        description            = "Allow connections from Labs MFA VPN clients"
      },
      {
        name                  = "NV-Cyclers"
        priority              = "220"
        direction             = "Inbound"
        source_address_prefix = "10.100.250.0/23"
        access                = "Allow"
        description           = "Allow connections from NV-Cyclers"
      },
    ]
  }
)
