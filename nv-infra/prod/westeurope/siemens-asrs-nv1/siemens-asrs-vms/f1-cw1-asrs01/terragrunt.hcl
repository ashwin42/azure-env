terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
}

dependency "global" {
  config_path = "../../global"
}

include {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-vms.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    network_interfaces = [
      {
        primary             = true
        name                = "${local.common.locals.vm_name}-nic1"
        security_group_name = "${local.common.locals.vm_name}-nsg"
        ip_configuration = [{
          subnet_id                     = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.46.0.19"
        }]
      }
    ]
  }
)

