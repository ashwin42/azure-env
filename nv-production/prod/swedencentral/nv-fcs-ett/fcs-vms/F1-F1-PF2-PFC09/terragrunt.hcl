terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.26"
}

include {
  path = find_in_parent_folders()
}

dependency "subnet" {
  config_path = "../../subnet/"
}

locals {
  name   = basename(get_terragrunt_dir())
  common = read_terragrunt_config(find_in_parent_folders("common-fcs-vms.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    network_interfaces = [
      {
        name = "${local.name}-nic"
        ip_configuration = [
          {
            private_ip_address            = "10.64.1.164"
            subnet_id                     = dependency.subnet.outputs.subnet["nv-fcs-ett-subnet-10.64.1.160_27"].id
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
        name                  = "NV-Cyclers_Old"
        priority              = "220"
        direction             = "Inbound"
        source_address_prefix = "10.100.250.0/23"
        access                = "Allow"
        description           = "Allow connections from NV-Cyclers old subnet"
      },
    ]
  }
)

