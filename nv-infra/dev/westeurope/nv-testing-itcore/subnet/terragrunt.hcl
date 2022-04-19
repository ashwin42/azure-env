terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.2.36"
  #source = "../../../../../../tf-mod-azure/vnet/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
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

