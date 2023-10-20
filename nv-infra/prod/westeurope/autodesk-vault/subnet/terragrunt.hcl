terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix = "nv-gen-infra-vnet"

  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name               = "autodesk-vault-subnet-10.46.1.0_29"
      netbox_subnet_name = "AutoDesk Vault subnet"
      address_prefixes   = ["10.46.1.0/29"]
    },
  ]
}

