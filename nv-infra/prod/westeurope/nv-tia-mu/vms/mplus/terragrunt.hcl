terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.4.0"
  #source = "../../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../subnet"
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    network_interfaces = [
      {
        name = "${local.common.inputs.name}-nic"
        ip_configuration = [
          {
            ipaddress                     = "10.46.1.69"
            subnet_id                     = dependency.vnet.outputs.subnet.tia-mu-subnet.id
            private_ip_address_allocation = "Static"
            ipconfig_name                 = "ipconfig"
          }
        ]
      }
    ]
  }
)
