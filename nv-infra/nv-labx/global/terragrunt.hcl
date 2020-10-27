terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//800xA_vm?ref=v0.1.1"
  source = "../../../../tf-mod-azure/global"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix              = "${basename(dirname(get_terragrunt_dir()))}"
  address_space             = [ "10.44.2.0/24" ]
  subnets                   = [ "10.44.2.0/26" ]
  dns_servers               = [ "10.40.250.5", "10.40.250.4" ]
  remote_virtual_network_id = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
  resource_group_name       = "nv_labx"
  recovery_vault_name       = "labx-rv"
  vnet_name                 = "nv_labx_vnet"
  vnet_peering_name         = "nv_labx_vnet_to_nv-hub"
  subnet_name               = "labx_subnet"
  lock_resources            = "false"
  service_endpoints         = [ "Microsoft.Sql" ]
}
