terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vpns2s?ref=v0.4.0"
  #source = "../../../../../tf-mod-azure/vpns2s"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpn_gateway" {
  config_path = "../vpn-gateway"
}

inputs = {
  resource_group_name           = dependency.vpn_gateway.outputs.virtual_network_gateway.nv-hub-swc-vpn-gw.resource_group_name
  key_vault_name                = include.root.inputs.secrets_key_vault_name
  key_vault_resource_group_name = include.root.inputs.secrets_key_vault_rg
  virtual_network_gateway_id    = dependency.vpn_gateway.outputs.virtual_network_gateway.nv-hub-swc-vpn-gw.id
  tunnels = [
    {
      name                = "ett-cloudvpn-01-internet-swc"
      secret_name         = "ett-cloudvpn-01-internet-swc-psk"
      gateway_address     = "195.198.29.234"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.30"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
    },
    {
      name                = "ett-cloudvpn-02-internet-swc"
      secret_name         = "ett-cloudvpn-02-internet-swc-psk"
      gateway_address     = "195.198.29.235"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.33"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
    },
    {
      name                = "labs-cloudvpn-01-internet-swc"
      secret_name         = "labs-cloudvpn-01-internet-swc-psk"
      gateway_address     = "213.50.54.200"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65308"
      bgp_peering_address = "169.254.0.20"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
    },
    {
      name                = "labs-cloudvpn-02-internet-swc"
      secret_name         = "labs-cloudvpn-02-internet-swc-psk"
      gateway_address     = "213.50.54.201"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65308"
      bgp_peering_address = "169.254.0.23"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
    },
  ]
}

