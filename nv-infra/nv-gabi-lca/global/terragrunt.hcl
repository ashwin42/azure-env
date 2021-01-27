terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix              = "nv-gabi-lca"
  address_space             = [ "10.44.5.136/29" ]
  subnets                   = [ "10.44.5.136/29" ]
  dns_servers               = [ "10.40.250.5", "10.40.250.4" ]
  remote_virtual_network_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}
