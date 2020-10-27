terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix              = "nv_network_mon"
  resource_group_name       = "nv_network_mon"
  nsg0_name_alt             = "nv_network_mon_nsg"
  address_space             = [ "10.44.3.0/24" ]
  subnets                   = [ "10.44.3.0/27", "10.44.3.32/27" ]
  subnet_names              = [ "nv_network_mon_subnet", "nv_nps_subnet" ]
  dns_servers               = [ "10.40.250.4", "10.40.250.5" ]
  remote_virtual_network_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
  recovery_vault_name       = "nv-network-mon-recovery-vault"
  vnet_peering_name         = "nv_network_mon_to_nv-hub"
  vnet_name                 = "nv_network_mon_vnet"
  lock_resources            = true
}
