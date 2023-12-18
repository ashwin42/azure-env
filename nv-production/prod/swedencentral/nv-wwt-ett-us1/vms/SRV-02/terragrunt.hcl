terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.3"
  source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
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
    #openssh      = true
    zones = ["2"]
    network_interfaces = [
      {
        name           = "${local.common.inputs.vm_name}-nic1"
        security_group = "${local.common.inputs.vm_name}-nsg"
        primary        = true
        ip_configuration = [{
          subnet_id                     = values(local.common.dependency.subnet.outputs.subnets)[0].id
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.64.1.23"
        }]
      }
    ]
  }
)

