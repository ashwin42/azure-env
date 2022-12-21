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
      resource_group_name = "core_network"
/*      records = [
        {
          name    = "dlmasterdataataccamadev"
          records = ["10.46.2.20"]
          ttl     = 300
        },
      ]
*/      
      virtual_network_links = [
        {
          name    = "core_vnet_vnl",
          vnet_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet",
        },
      ]
    },
  ]
}

