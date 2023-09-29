terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
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
    install_winrm      = true
    network_interfaces = [
      {
        name    = "dwa-wcs-nic1"
        primary = true
        ip_configuration = [{
          subnet_id                     = local.common.dependency.subnet.outputs.subnets["siemens-wcs-subnet1"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.46.97.39"
        }]
      }
    ]
  }
)

