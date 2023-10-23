terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "erp_prod_vnet"
  vnet_resource_group_name = "erp_prod"
  subnets = [
    {
      name               = "nv-lasernet-subnet-10.46.32.32_28"
      netbox_subnet_name = "nv-lasernet"
      address_prefixes   = ["10.46.32.32/28"]
    },
  ]
}

