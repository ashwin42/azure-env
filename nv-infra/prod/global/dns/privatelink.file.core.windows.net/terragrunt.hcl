terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//dns?ref=v0.6.13"
  #source = "../../../../../../tf-mod-azure//dns/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  private_dns_zones = [
    {
      name                = basename(get_terragrunt_dir())
      resource_group_name = "nv_infra"
      records = [
        {
          name    = "qcsftpstorage"
          records = ["10.44.2.5"]
          ttl     = 300
        },
        {
          name    = "qcsftpstorage2"
          records = ["10.44.2.16"]
          ttl     = 300
        },
        {
          name    = "qcsftpstoragect2"
          records = ["10.44.2.11"]
          ttl     = 300
        },
      ]
      virtual_network_links = [
        {
          name    = "core_vnet_vnl",
          vnet_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet",
        },
      ]
    },
  ]
}
