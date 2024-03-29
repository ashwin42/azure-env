terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.3.5"
}

dependency "vnet" {
  config_path = "../../nv-octoplant/subnet"
}

dependency "private_dns" {
  config_path = "../../../global/dns/file.core.windows.net"
}


include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  storage_account_name              = "octoplantlabsfs"
  subnet_id                         = dependency.vnet.outputs.subnet["nv-octoplant-10.46.1.8_29"].id
  vnet_id                           = dependency.vnet.outputs.virtual_network.id
  dns_zone_name                     = "privatelink.file.core.windows.net"
  dns_zone_rg                       = dependency.private_dns.outputs.private_dns_zone["privatelink.file.core.windows.net"].resource_group_name
  enable_advanced_threat_protection = false
  enable_ad_auth                    = true
  file_shares = [
    { name = "octoplant", quota = 500 },
  ]
  network_rules = [
    {
      name           = "Allow_Subnets"
      default_action = "Allow"
      subnet_ids     = [dependency.vnet.outputs.subnet["nv-octoplant-10.46.1.8_29"].id]
      bypass         = ["AzureServices"]
      enable_ad_auth = true
    },
  ]
}
