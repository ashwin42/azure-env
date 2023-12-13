terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.9.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//storage"
}

dependency "vnet" {
  config_path = "../subnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  storage_account_name              = "octoplantfs"
  subnet_id                         = dependency.vnet.outputs.subnets["nv-octoplant-10.46.1.8_29"].id
  vnet_id                           = dependency.vnet.outputs.virtual_network.id
  enable_advanced_threat_protection = false
  allow_nested_items_to_be_public   = false
  enable_ad_auth                    = true
  file_shares = [
    { name = "octoplant", quota = 1000 },
  ]
}
