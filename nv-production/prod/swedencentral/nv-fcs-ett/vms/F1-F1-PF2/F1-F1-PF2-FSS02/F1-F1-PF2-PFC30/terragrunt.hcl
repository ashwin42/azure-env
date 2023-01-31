terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.26"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vm"
}

include {
  path = find_in_parent_folders()
}

dependency "subnet" {
  config_path = "../../../../subnet/"
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
            private_ip_address            = "10.64.1.178"
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
        access                 = "Allow"
        description            = "Allow connections from Labs MFA VPN clients"
      },
      {
        name                  = "Ett_MFA_VPN"
        priority              = "201"
        direction             = "Inbound"
        source_address_prefix = "10.240.0.0/21"
        description           = "Allow connections from Ett MFA VPN clients"
      },
    ]
  }
)

