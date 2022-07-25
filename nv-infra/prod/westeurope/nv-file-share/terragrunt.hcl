terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.5.0"
}

dependency "global" {
  config_path = "../vnet"
}

dependency "private_dns" {
  config_path = "../../global/dns/file.core.windows.net"
}

dependency "e3-global" {
  config_path = "../nv-e3/global"
}

dependency "labx-global" {
  config_path = "../nv-labx/global/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  storage_account_name              = "nvinfrafs"
  resource_group_name               = dependency.global.outputs.resource_group.name
  location                          = dependency.global.outputs.resource_group.location
  subnet_id                         = dependency.global.outputs.subnet.vdi_subnet.id
  vnet_id                           = dependency.global.outputs.virtual_network.id
  dns_zone_name                     = "privatelink.file.core.windows.net"
  dns_zone_rg                       = dependency.private_dns.outputs.private_dns_zone["privatelink.file.core.windows.net"].resource_group_name
  enable_advanced_threat_protection = false
  enable_ad_auth                    = true
  file_shares = [
    { name = "e3-battery-systems", quota = 10 },
    { name = "e3-labs-maintenance", quota = 10 },
    { name = "labware-8", quota = 10 },
  ]
  network_rules = [
    {
      name       = "Allow_VNETs"
      subnet_ids = [dependency.e3-global.outputs.subnet["nv-e3-subnet-10.44.5.128"].id, dependency.labx-global.outputs.subnet.labx_subnet.id]
      bypass     = ["AzureServices"]
    },
  ]
}
