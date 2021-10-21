terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.18"
  #source = "../../../../../../tf-mod-azure/global/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix             = "nv-cmx"
  vnet_name                = "nv-gen-infra-vnet"
  vnet_resource_group_name = "nv-gen-infra-rg"
  subnets = [
    {
      name                 = "nv-cmx-subnet-10.46.0.64-28"
      address_prefixes     = ["10.46.0.64/28"]
      service_endpoints    = ["Microsoft.Sql"]
      enforce_private_link = true
    },
  ]
}

