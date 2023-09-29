terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//dns?ref=v0.6.13"
  #source = "../../../../../../tf-mod-azure//dns/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  private_dns_zones = [
    {
      name                = basename(get_terragrunt_dir())
      resource_group_name = "core_network"
      records = [
        {
          name    = "nv-e3-sql"
          records = ["10.44.5.133"]
          ttl     = 300
        },
        {
          name    = "nv-siemens-sql"
          records = ["10.44.1.132"]
          ttl     = 300
        },
        {
          name    = "nv-toolsnet-sql"
          records = ["10.46.1.20"]
          ttl     = 300
        },
        {
          name    = "nv-wuxi"
          records = ["10.42.0.4"]
          ttl     = 300
        },
      ]
      virtual_network_links = [
        {
          name    = "core_vnet",
          vnet_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet",
        },
      ]
    },
  ]
}
