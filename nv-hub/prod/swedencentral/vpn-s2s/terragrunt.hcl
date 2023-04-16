terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vpns2s?ref=v0.7.13"
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
  resource_group_name           = dependency.vpn_gateway.outputs.virtual_network_gateways.nv-hub-swc-vpn-gw.resource_group_name
  key_vault_name                = include.root.inputs.secrets_key_vault_name
  key_vault_resource_group_name = include.root.inputs.secrets_key_vault_rg
  virtual_network_gateway_id    = dependency.vpn_gateway.outputs.virtual_network_gateways.nv-hub-swc-vpn-gw.id
  tunnels = [
    {
      name                = "ett-cloudvpn-03-internet-swc"
      secret_name         = "ett-cloudvpn-03-internet-swc-psk"
      gateway_address     = "195.198.29.231"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.34"
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
      name                = "ett-cloudvpn-04-internet-swc"
      secret_name         = "ett-cloudvpn-04-internet-swc-psk"
      gateway_address     = "195.198.29.232"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.35"
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
    {
      name                = "aws-network-prod-eu-north-1-tgw-01-a"
      secret_name         = "aws-network-prod-eu-north-1-tgw-01-a-psk"
      gateway_address     = "13.51.4.106"
      address_space       = "10.11.0.0/16,10.12.0.0/14,10.18.0.0/15,10.20.0.0/14,10.24.0.0/13,10.32.0.0/13"
      enable_bgp          = false
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
      name                = "aws-network-prod-eu-north-1-tgw-01-b"
      secret_name         = "aws-network-prod-eu-north-1-tgw-01-b-psk"
      gateway_address     = "16.170.125.155"
      address_space       = "10.11.0.0/16,10.12.0.0/14,10.18.0.0/15,10.20.0.0/14,10.24.0.0/13,10.32.0.0/13"
      enable_bgp          = false
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
      name                = "aws-network-prod-eu-north-1-tgw-02-a"
      secret_name         = "aws-network-prod-eu-north-1-tgw-02-a-psk"
      gateway_address     = "13.48.94.192"
      address_space       = "10.11.0.0/16,10.12.0.0/14,10.18.0.0/15,10.20.0.0/14,10.24.0.0/13,10.32.0.0/13"
      enable_bgp          = false
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
      name                = "aws-network-prod-eu-north-1-tgw-02-b"
      secret_name         = "aws-network-prod-eu-north-1-tgw-02-b-psk"
      gateway_address     = "13.48.158.217"
      address_space       = "10.11.0.0/16,10.12.0.0/14,10.18.0.0/15,10.20.0.0/14,10.24.0.0/13,10.32.0.0/13"
      enable_bgp          = false
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
      name                = "dwa-01-internet-swc"
      secret_name         = "dwa-01-internet-swc-psk"
      gateway_address     = "37.128.85.102"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65362"
      bgp_peering_address = "169.254.0.129"
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
      name                = "dwa-02-internet-swc"
      secret_name         = "dwa-02-internet-swc-psk"
      gateway_address     = "37.128.85.103"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65362"
      bgp_peering_address = "169.254.0.133"
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
