terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//private_dns?ref=v0.2.4"
  source = "../../../../../../tf-mod-azure/private_dns/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "nv_infra"
  zones               = ["privatelink.file.core.windows.net"]
  virtual_network_id  = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}
