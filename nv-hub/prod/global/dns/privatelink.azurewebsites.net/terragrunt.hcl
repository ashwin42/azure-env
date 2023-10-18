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
          name    = "asrs-nv1-prod-anode-as"
          records = ["10.46.0.7"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-anode-as.scm"
          records = ["10.46.0.7"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-cathode-as"
          records = ["10.46.0.5"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-cathode-as.scm"
          records = ["10.46.0.5"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-cw1-as"
          records = ["10.46.0.8"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-cw1-as.scm"
          records = ["10.46.0.8"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-fa1-as"
          records = ["10.46.0.9"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-fa1-as.scm"
          records = ["10.46.0.9"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-spw-as"
          records = ["10.46.0.10"]
          ttl     = 300
        },
        {
          name    = "asrs-nv1-prod-spw-as.scm"
          records = ["10.46.0.10"]
          ttl     = 300
        },
        {
          name    = "asrs-wcs-dev-as"
          records = ["10.44.5.182"]
          ttl     = 300
        },
        {
          name    = "asrs-wcs-dev-as.scm"
          records = ["10.44.5.182"]
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
