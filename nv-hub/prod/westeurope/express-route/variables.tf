// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

variable "subscription_id" {}

variable "remote_800xa_vnet" {
  default = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/800xa/providers/Microsoft.Network/virtualNetworks/800xa"
}

variable "remote_csp_vnet" {
  default = "/subscriptions/f23047bd-1342-4fdf-a81c-00c91500455f/resourceGroups/nv-core/providers/Microsoft.Network/virtualNetworks/nv-core-vnet"
}

variable "remote_wuxi_vnet" {
  default = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/nv-wuxi-lead/providers/Microsoft.Network/virtualNetworks/wuxi-vnet"
}

variable "remote_infra_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_infra/providers/Microsoft.Network/virtualNetworks/nv_infra"
}

variable "remote_siemens_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_siemens/providers/Microsoft.Network/virtualNetworks/nv_siemens_vnet"
}

variable "remote_network_mon_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_network_mon/providers/Microsoft.Network/virtualNetworks/nv_network_mon_vnet"
}

variable "remote_polarion_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_polarion/providers/Microsoft.Network/virtualNetworks/nv_polarion_vnet"
}

variable "remote_nv_labx_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_labx/providers/Microsoft.Network/virtualNetworks/nv_labx_vnet"
}

variable "remote_nv_arx_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/arx-rg/providers/Microsoft.Network/virtualNetworks/arx-vnet"
}

variable "remote_nv_pne_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-pne-rg/providers/Microsoft.Network/virtualNetworks/nv-pne-vnet"
}

variable "remote_nv_test_wvd_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-test-wvd-rg/providers/Microsoft.Network/virtualNetworks/nv-test-wvd-vnet"
}

variable "remote_nv_cell_assembly_ws_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-cell-assembly-ws-rg/providers/Microsoft.Network/virtualNetworks/nv-cell-assembly-ws-vnet"
}

variable "remote_nv_e3_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-e3-rg/providers/Microsoft.Network/virtualNetworks/nv-e3-vnet"
}

variable "remote_nv_gabi_lca_vnet" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-gabi-lca-rg/providers/Microsoft.Network/virtualNetworks/nv-gabi-lca-vnet"
}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv-production/core_network"
  }
}
