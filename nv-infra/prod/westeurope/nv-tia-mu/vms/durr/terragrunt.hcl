terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  # source = "../../../../../../../tf-mod-azure//vm/netbox"
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
  ip_address = "10.46.1.74"
}

inputs = merge(
  local.common.inputs,
  {
    dns_record = local.ip_address
    vm_size    = "Standard_B2ms"
    network_interfaces = [
      {
        name = "${local.common.inputs.dns_name}-nic"
        ip_configuration = [
          {
            private_ip_address            = local.ip_address
            subnet_id                     = dependency.vnet.outputs.subnet.tia-mu-subnet.id
            private_ip_address_allocation = "Static"
            ipconfig_name                 = "ipconfig"
          }
        ]
      }
    ]
  }
)
