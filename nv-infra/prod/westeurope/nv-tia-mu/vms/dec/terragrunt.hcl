terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.5.2"
  #source = "../../../../../../../tf-mod-azure//vm/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../subnet"
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-tia.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    network_interfaces = [
      {
        name = "${local.common.inputs.dns_name}-nic"
        ip_configuration = [
          {
            private_ip_address            = "10.46.1.71"
            subnet_id                     = dependency.vnet.outputs.subnet.tia-mu-subnet.id
            private_ip_address_allocation = "Static"
            ipconfig_name                 = "ipconfig"
          }
        ]
      }
    ]
  }
)
