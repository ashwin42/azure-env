terraform {
  source = "github.com/northvolt/tf-mod-azure//vnet?ref=v0.8.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/"
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
      name             = "nv-lasernet-subnet-10.46.32.0_28"
      address_prefixes = ["10.46.32.0/28"]
    },
  ]
}

