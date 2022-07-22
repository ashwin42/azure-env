terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.4.0"
  #source = "../../../tf-mod-azure/global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name   = "core_network"
  setup_prefix          = "core_vnet"
  vnet_name             = "core_vnet"
  address_space         = ["10.40.0.0/16"]
  dns_servers           = ["10.40.250.4", "10.40.250.5"]
  create_recovery_vault = false
  lock_resources        = true
  subnets = [
    {
      name              = "hub-dmz"
      address_prefixes  = ["10.40.253.0/24"]
      service_endpoints = []
    },
    {
      name              = "nv-domain-services"
      address_prefixes  = ["10.40.250.0/24"]
      service_endpoints = []
    },
    {
      name              = "GatewaySubnet"
      address_prefixes  = ["10.40.254.0/24"]
      service_endpoints = []
    },
  ]
  peerings = [
    {
      name                = "hub-we2hub-swc",
      vnet_id             = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/hub_rg/providers/Microsoft.Network/virtualNetworks/hub_vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv-production",
      vnet_id             = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/800xa/providers/Microsoft.Network/virtualNetworks/800xa"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_csp",
      vnet_id             = "/subscriptions/f23047bd-1342-4fdf-a81c-00c91500455f/resourceGroups/nv-core/providers/Microsoft.Network/virtualNetworks/nv-core-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_infra",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_infra/providers/Microsoft.Network/virtualNetworks/nv_infra"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_arx_vnet",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/arx-rg/providers/Microsoft.Network/virtualNetworks/arx-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_cell_assembly_ws_vnet",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-cell-assembly-ws-rg/providers/Microsoft.Network/virtualNetworks/nv-cell-assembly-ws-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_e3_vnet",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-e3-rg/providers/Microsoft.Network/virtualNetworks/nv-e3-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_gabi_lca_vnet",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-gabi-lca-rg/providers/Microsoft.Network/virtualNetworks/nv-gabi-lca-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_labx_vnet",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_labx/providers/Microsoft.Network/virtualNetworks/nv_labx_vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_network_mon",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_network_mon/providers/Microsoft.Network/virtualNetworks/nv_network_mon_vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_pne_vnet",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-pne-rg/providers/Microsoft.Network/virtualNetworks/nv-pne-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_polarion",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_polarion/providers/Microsoft.Network/virtualNetworks/nv_polarion_vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv_test_wvd_vnet",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-test-wvd-rg/providers/Microsoft.Network/virtualNetworks/nv-test-wvd-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_siemens",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_siemens/providers/Microsoft.Network/virtualNetworks/nv_siemens_vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_wuxi",
      vnet_id             = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/nv-wuxi-lead/providers/Microsoft.Network/virtualNetworks/wuxi-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_revolt-wave4",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/revolt-wave4-rg/providers/Microsoft.Network/virtualNetworks/revolt-wave4-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_asrs-wcs-dev",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/asrs-nv1-dev-rg/providers/Microsoft.Network/virtualNetworks/asrs-nv1-dev-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_infosec-wvd",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/infosec-wvd-rg/providers/Microsoft.Network/virtualNetworks/infosec-wvd-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_print-gw",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/print-gw-rg/providers/Microsoft.Network/virtualNetworks/print-gw-vnet"
      use_remote_gateways = false
    },
    {
      name                = "nv-hub_to_nv-gen-infra-vnet",
      vnet_id             = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-gen-infra-rg/providers/Microsoft.Network/virtualNetworks/nv-gen-infra-vnet"
      use_remote_gateways = false
    },
  ]
}
