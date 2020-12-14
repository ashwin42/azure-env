terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.2"
  #source = "../../../tf-mod-azure/global/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix              = "nv_infra"
  address_space             = [ "10.80.0.0/16" ]
  subnets                   = [ "10.80.0.0/27" ]
  subnet_names              = [ "vdi_subnet" ]
  dns_servers               = [ "10.40.250.4", "10.40.250.5" ]
  remote_virtual_network_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
  create_recovery_vault     = false
  resource_group_name       = "nv_infra"
  vnet_name                 = "nv_infra"
  vnet_peering_name         = "nv_infra_to_nv-hub"
  lock_resources            = true
  service_endpoints         = [ "Microsoft.Storage" ]
  enforce_private_link      = true
}
