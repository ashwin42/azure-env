terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm"
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
    netbox_create_role = true
    network_interfaces = [
      {
        primary             = true
        name                = "${local.common.locals.name}-nic1"
        security_group_name = "${local.common.locals.name}-nsg"
        ip_configuration = [{
          subnet_id                     = local.common.dependency.subnet.outputs.subnets["${include.root.locals.all_vars.project}-subnet1"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.46.97.102"
        }]
      }
    ]
  }
)

