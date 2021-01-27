terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.2.4"
}

dependency "global" {
  config_path = "../vnet"
}

dependency "private_dns" {
  config_path = "../private_dns/file.core.windows.net"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  storage_account_name              = "nvinfrafs"
  resource_group_name               = dependency.global.outputs.resource_group.name
  location                          = dependency.global.outputs.resource_group.location
  subnet_id                         = dependency.global.outputs.subnet["10.80.0.0/27"].id
  vnet_id                           = dependency.global.outputs.virtual_network.id
  dns_zone_name                     = "privatelink.file.core.windows.net"
  dns_zone_rg                       = dependency.private_dns.outputs.private_dns_zone["privatelink.file.core.windows.net"].resource_group_name
  enable_advanced_threat_protection = false
  enable_ad_auth                    = true
  file_shares = [
    { name = "e3-battery-systems", quota = 10 },
    { name = "e3-labs-maintenance", quota = 10 }
  ]
  network_rules = [
    {
      name       = "default_rule"
      subnet_ids = ["/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-e3-rg/providers/Microsoft.Network/virtualNetworks/nv-e3-vnet/subnets/nv-e3-subnet-10.44.5.128"]
      bypass     = ["AzureServices"]
    }
  ]
}
