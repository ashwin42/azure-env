terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix        = "nv_siemens"
  vnet_name           = "nv_siemens_vnet"
  resource_group_name = "nv_siemens"
  recovery_vault_name = "nv-siemens-recovery-vault"
  address_space       = ["10.44.1.0/24"]
  dns_servers         = ["10.40.250.4", "10.40.250.5"]
  soft_delete_enabled = false
  nsg_name            = "nv_siemens_nsg"
  subnets = [
    {
      name                 = "siemens_fs20_fire"
      address_prefixes     = ["10.44.1.0/27"]
      service_endpoints    = []
      enforce_private_link = false
    },
    {
      name                 = "siemens_cameras"
      address_prefixes     = ["10.44.1.32/27"]
      service_endpoints    = []
      enforce_private_link = false
    },
    {
      name                 = "siemens_spc_controllers"
      address_prefixes     = ["10.44.1.64/27"]
      service_endpoints    = []
      enforce_private_link = false
    },
    {
      name                 = "siemens_sipass_controllers"
      address_prefixes     = ["10.44.1.96/27"]
      service_endpoints    = []
      enforce_private_link = false
    },
    {
      name                 = "siemens_system_subnet"
      address_prefixes     = ["10.44.1.128/26"]
      service_endpoints    = ["Microsoft.Sql"]
      enforce_private_link = true
    },
    {
      name                 = "AzureBastionSubnet"
      address_prefixes     = ["10.44.1.192/27"]
      service_endpoints    = []
      enforce_private_link = false
    },
  ]
  peerings = [
    {
      name                         = "nv_siemens_to_nv-hub",
      vnet_id                      = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
      allow_gateway_transit        = false
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
      use_remote_gateways          = true
    },
    {
      name                         = "nv_siemens_to_nv-arx",
      vnet_id                      = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/arx-rg/providers/Microsoft.Network/virtualNetworks/arx-vnet"
      allow_gateway_transit        = false
      allow_virtual_network_access = true
      allow_forwarded_traffic      = false
      use_remote_gateways          = false
    },
  ]

  iam_assignments = {
    "Reader" = {
      users = ["karel.silha@northvolt.com"]
    },
  },
}


