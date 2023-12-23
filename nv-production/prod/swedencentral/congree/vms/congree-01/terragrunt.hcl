terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.3"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
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
    localadmin_key_name = "congree-nvadmin"
    network_interfaces = [
      {
        name = "${local.common.inputs.name}-nic"
        ip_configuration = [
          {
            private_ip_address            = "10.64.1.132"
            subnet_id                     = local.common.dependency.vnet.outputs.subnets["congree-subnet"].id
            public_ip                     = false
            private_ip_address_allocation = "Static"
          },
        ]
      },
    ]
  }
)
