terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.20"
  #source = "../../../../../../tf-mod-azure//vm/"
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
