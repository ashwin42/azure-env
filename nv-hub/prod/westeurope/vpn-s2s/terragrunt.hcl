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
  resource_group_name           = "core_network"
  key_vault_name                = "nv-hub-core"
  key_vault_resource_group_name = "nv-hub-core"
  virtual_network_gateway_id    = dependency.vpn_gateway.outputs.virtual_network_gateways.nw-hub-vpn-gw-core.id
  tunnels = [
    {
      name                       = "aws_ireland_dev_tgw"
      local_network_gateway_name = "aws-ireland-dev-tgw"
      routing_table_name         = "aws_ireland_dev_tgw_routingtable"
      gateway_address            = "52.18.92.185"
      address_space              = "10.11.0.0/16"
      address_prefix             = "10.11.0.0/16"
      enable_bgp                 = "false"
      generate_psk               = false
    },
    {
      name                       = "aws_stockholm_prod_tgw"
      local_network_gateway_name = "aws-stockholm-prod-tgw"
      routing_table_name         = "aws_stockholm_prod_tgw_routingtable"
      gateway_address            = "13.48.37.70"
      address_space              = "10.13.0.0/16,10.23.0.0/16,10.33.0.0/16,10.104.0.0/16,10.22.0.0/25"
      address_prefix             = "10.13.0.0/16,10.23.0.0/16,10.33.0.0/16,10.104.0.0/16"
      enable_bgp                 = "false"
      generate_psk               = false
    },
    {
      name                = "aws-network-prod-eu-west-1-tgw-01-a"
      gateway_address     = "34.253.167.76"
      address_space       = "10.21.0.0/16"
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
      name                = "aws-network-prod-eu-west-1-tgw-01-b"
      gateway_address     = "52.212.88.129"
      address_space       = "10.21.0.0/16"
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
      name                = "azure-to-labs-s2s"
      gateway_address     = "213.50.54.194"
      address_space       = "10.244.255.0/30"
      enable_bgp          = "true"
      bgp_asn             = "65307"
      bgp_peering_address = "10.244.255.2"
      dh_group            = "DHGroup14"
      ike_encryption      = "AES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "AES256"
      ipsec_integrity     = "SHA256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
      generate_psk        = false
    },
    {
      name                = "revolt-ett-cldro001-internet"
      gateway_address     = "194.218.37.167"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65002"
      bgp_peering_address = "169.254.0.47"
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
      name                = "revolt-ett-cldro002-internet"
      gateway_address     = "194.218.37.168"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65002"
      bgp_peering_address = "169.254.0.48"
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
      name                = "revolt-ett-temp-cldro001-internet"
      gateway_address     = "194.17.162.251"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65002"
      bgp_peering_address = "169.254.0.26"
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
      name                = "revolt-ett-temp-cldro002-internet"
      gateway_address     = "194.17.162.252"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65002"
      bgp_peering_address = "169.254.0.27"
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
      name                = "ett-cloudvpn-01-internet"
      gateway_address     = "194.17.162.199"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.13"
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
      name                = "ett-cloudvpn-02-internet"
      gateway_address     = "194.17.162.200"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.14"
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
      name                = "ett-cloudvpn-03-internet"
      gateway_address     = "195.198.29.231"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.17"
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
      name                = "ett-cloudvpn-04-internet"
      gateway_address     = "195.198.29.232"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65327"
      bgp_peering_address = "169.254.0.18"
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
      name                = "labs-cloudvpn-01-internet"
      gateway_address     = "213.50.54.200"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65308"
      bgp_peering_address = "169.254.0.15"
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
      name                = "labs-cloudvpn-02-internet"
      gateway_address     = "213.50.54.201"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65308"
      bgp_peering_address = "169.254.0.16"
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
      name                       = "rnd-temp-office"
      local_network_gateway_name = "rnd-temp-office"
      gateway_address            = "92.43.35.134"
      address_space              = "10.16.32.0/23"
      address_prefix             = "10.16.32.0/23"
      enable_bgp                 = "false"
      generate_psk               = false
    },
    {
      name                       = "drei-office"
      local_network_gateway_name = "drei-office"
      gateway_fqdn               = "drei-fw01-crvrkkmdmk.dynamic-m.com"
      address_space              = "10.17.0.0/22,10.193.9.0/24"
      address_prefix             = "10.17.0.0/22,10.193.9.0/24"
      enable_bgp                 = "false"
      generate_psk               = false
    },
    {
      name                = "dwa-01-internet"
      gateway_address     = "37.128.85.102"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65362"
      bgp_peering_address = "169.254.0.136"
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
      name                = "dwa-02-internet"
      gateway_address     = "37.128.85.103"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65362"
      bgp_peering_address = "169.254.0.137"
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
      name                = "labs-edge-cldro001-internet-we"
      gateway_address     = "212.247.38.100"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65308"
      bgp_peering_address = "169.254.0.11"
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
      name                = "labs-edge-cldro002-internet-we"
      gateway_address     = "212.247.38.101"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65308"
      bgp_peering_address = "169.254.0.12"
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
      name                       = "drei-office-7th-floor"
      local_network_gateway_name = "drei-office-7th-floor"
      gateway_address            = "24.40.143.226"
      address_space              = "10.193.62.0/24,10.17.4.0/22"
      address_prefix             = "10.193.62.0/24,10.17.4.0/22"
      dh_group                   = "DHGroup14"
      ike_encryption             = "AES256"
      ike_integrity              = "SHA256"
      ipsec_encryption           = "AES256"
      ipsec_integrity            = "SHA256"
      pfs_group                  = "PFS2"
      sa_lifetime                = "28800"
      sa_datasize                = "2147483647"
      dpd_timeout_seconds        = "45"
      enable_bgp                 = "false"
      generate_psk               = true
    },
    {
      name                       = "disponent-01-azure-internet"
      local_network_gateway_name = "disponent-01-azure-internet"
      gateway_address            = "134.65.165.214"
      address_space              = "10.193.10.0/24,10.16.100.0/22"
      address_prefix             = "10.193.10.0/24,10.16.100.0/22"
      dh_group                   = "DHGroup14"
      ike_encryption             = "AES256"
      ike_integrity              = "SHA256"
      ipsec_encryption           = "AES256"
      ipsec_integrity            = "SHA256"
      pfs_group                  = "PFS2"
      sa_lifetime                = "28800"
      sa_datasize                = "2147483647"
      dpd_timeout_seconds        = "45"
      enable_bgp                 = "false"
      generate_psk               = true
    },
    {
      name                = "pnl2-fw001-internet-we"
      gateway_address     = "62.20.20.219"
      address_space       = ""
      enable_bgp          = "true"
      bgp_asn             = "65402"
      bgp_peering_address = "169.254.0.50"
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
      name                       = "cuberg-camera"
      local_network_gateway_name = "cuberg-camera"
      gateway_address            = "64.201.242.2"
      address_space              = "10.193.63.0/24"
      address_prefix             = "10.193.63.0/24"
      dh_group                   = "DHGroup14"
      ike_encryption             = "AES256"
      ike_integrity              = "SHA256"
      ipsec_encryption           = "AES256"
      ipsec_integrity            = "SHA256"
      pfs_group                  = "PFS2"
      sa_lifetime                = "28800"
      sa_datasize                = "2147483647"
      dpd_timeout_seconds        = "45"
      enable_bgp                 = "false"
      generate_psk               = true
    },
  ]
}
