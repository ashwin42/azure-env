terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vnet/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  vnet_name                = "labs-prod-general"
  vnet_resource_group_name = "labs-prod-general-rg"
  subnets = [
    {
      name               = "rd2-hangke-10.64.97.0_29"
      address_prefixes   = ["10.64.97.0/29"]
      netbox_subnet_name = "rd2-hangke-subnet"
      netbox_is_pool     = false
    },
  ]
}
