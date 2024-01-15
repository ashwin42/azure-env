terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vpns2s?ref=v0.10.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vpns2s"
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
      name                = "revolt-ett-cldro001-internet-swc"
      gateway_address     = "194.218.37.167"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65002"
      bgp_peering_address = "169.254.0.45"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES128"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES128"
      ipsec_integrity     = "GCMAES128"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
      generate_psk        = true
    },
    {
      name                = "revolt-ett-cldro002-internet-swc"
      gateway_address     = "194.218.37.168"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65002"
      bgp_peering_address = "169.254.0.46"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES128"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES128"
      ipsec_integrity     = "GCMAES128"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
      generate_psk        = true
    },
    {
      name                = "revolt-ett-temp-cldro001-internet-swc"
      gateway_address     = "194.17.162.251"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65002"
      bgp_peering_address = "169.254.0.24"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
      generate_psk        = true
    },
    {
      name                = "revolt-ett-temp-cldro002-internet-swc"
      gateway_address     = "194.17.162.252"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65002"
      bgp_peering_address = "169.254.0.25"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
      generate_psk        = true
    },
    {
      name                = "ett-cloudvpn-01-internet-swc"
      gateway_address     = "194.17.162.199"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.32"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
      generate_psk        = false
    },
    {
      name                = "ett-cloudvpn-02-internet-swc"
      gateway_address     = "194.17.162.200"
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
      generate_psk        = false
    },
    {
      name                = "ett-cloudvpn-03-internet-swc"
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
      generate_psk        = false
    },
    {
      name                = "ett-cloudvpn-04-internet-swc"
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
      generate_psk        = false
    },
    {
      name                = "labs-cloudvpn-01-internet-swc"
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
      generate_psk        = false
    },
    {
      name                = "labs-cloudvpn-02-internet-swc"
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
      generate_psk        = false
    },
    {
      name                = "aws-network-prod-eu-north-1-tgw-01-a"
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
      generate_psk        = false
    },
    {
      name                = "aws-network-prod-eu-north-1-tgw-01-b"
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
      generate_psk        = false
    },
    {
      name                = "aws-network-prod-eu-north-1-tgw-02-a"
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
      generate_psk        = false
    },
    {
      name                = "aws-network-prod-eu-north-1-tgw-02-b"
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
      generate_psk        = false
    },
    {
      name                = "dwa-01-internet-swc"
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
      generate_psk        = false
    },
    {
      name                = "dwa-02-internet-swc"
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
      generate_psk        = false
    },
    {
      name                       = "rv1-temp-siemens"
      local_network_gateway_name = "rv1-temp-siemens"
      gateway_address            = "31.208.251.162"
      address_space              = "192.168.100.0/24"
      address_prefix             = "192.168.100.0/24"
      enable_bgp                 = "false"
      generate_psk               = false
    },
    {
      name                = "labs-edge-cldro001-internet-swc"
      gateway_address     = "212.247.38.100"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65308"
      bgp_peering_address = "169.254.0.9"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
      generate_psk        = true
    },
    {
      name                = "labs-edge-cldro002-internet-swc"
      gateway_address     = "212.247.38.101"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65308"
      bgp_peering_address = "169.254.0.10"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES256"
      ipsec_integrity     = "GCMAES256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
      generate_psk        = true
    },
    {
      name                = "pnl2-fw001-internet-swc"
      gateway_address     = "62.20.20.219"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65402"
      bgp_peering_address = "169.254.0.49"
      dh_group            = "DHGroup14"
      ike_encryption      = "GCMAES128"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "GCMAES128"
      ipsec_integrity     = "GCMAES128"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      sa_datasize         = "2147483647"
      dpd_timeout_seconds = "45"
      generate_psk        = true
    },
  ]
}
