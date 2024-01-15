terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet/netbox?ref=v0.10.4"
  #source = "../../../../../../tf-mod-azure/vnet/"
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
      name                 = "nv-test-itcore-subnet-10.46.0.192-254"
      address_prefixes     = ["10.46.0.192/26"]
      service_endpoints    = ["Microsoft.Sql"]
      enforce_private_link = true
    },
  ]
}

