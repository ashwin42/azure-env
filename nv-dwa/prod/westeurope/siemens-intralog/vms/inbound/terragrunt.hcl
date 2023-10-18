terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.9"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

generate = merge(
  include.root.locals.generate_providers.netbox,
  include.root.locals.generate_providers_version_override.netbox
)

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-vms.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    netbox_create_role = true
    network_interfaces = [
      {
        primary = true
        name    = "${local.common.locals.vm_name}-nic1"
        ip_configuration = [{
          subnet_id                     = local.common.dependency.subnet.outputs.subnets["siemens-wcs-subnet1"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.46.97.41"
        }]
      }
    ]
  }
)

