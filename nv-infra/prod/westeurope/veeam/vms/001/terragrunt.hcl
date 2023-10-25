terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.2"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-vms.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    network_interfaces = [
      {
        name = "${local.common.inputs.vm_name}-nic0"
        ip_configuration = [{
          subnet_id                     = local.common.dependency.subnet.outputs.subnets["veeam-subnet"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.46.2.116"
        }]
      }
    ]
  }
)

