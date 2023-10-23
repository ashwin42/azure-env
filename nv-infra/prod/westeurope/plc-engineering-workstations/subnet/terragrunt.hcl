terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix             = ""
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name               = "nv-plc-ews-10.46.1.32_28"
      netbox_subnet_name = "nv-plc-ews: PLC Engineering Workstations"
      address_prefixes   = ["10.46.1.32/28"]
    },
  ]
}

