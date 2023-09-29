terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  # source = "${dirname(get_repo_root())}/tf-mod-azure/vm//netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../subnet"
}

locals {
  common     = read_terragrunt_config(find_in_parent_folders("common-tia.hcl"))
  private_ip = "10.46.1.75"
}

inputs = merge(
  local.common.inputs,
  {
    dns_record = local.private_ip
    network_interfaces = [
      {
        name = "${local.common.inputs.name}-nic"
        ip_configuration = [
          {
            private_ip_address            = local.private_ip
            subnet_id                     = dependency.vnet.outputs.subnet.tia-mu-subnet.id
            private_ip_address_allocation = "Static"
            ipconfig_name                 = "ipconfig"
          }
        ]
      }
    ]
  }
)

