resource "azurerm_virtual_network_peering" "nv_polarion_to_nv-hub" {
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    allow_virtual_network_access = true
    name                         = "nv_polarion_to_nv-hub"
    remote_virtual_network_id    = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
    resource_group_name          = "nv_polarion"
    use_remote_gateways          = true
    virtual_network_name         = "nv_polarion_vnet"
}
