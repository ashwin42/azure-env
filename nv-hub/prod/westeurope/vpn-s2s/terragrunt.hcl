terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vpns2s?ref=v0.2.7"
  #source = "../../../../../tf-mod-azure/vpns2s"
}

include {
  path = find_in_parent_folders()
}

dependency "vpn_gateway" {
  config_path = "../vpn-gateway"
}

inputs = {
  resource_group_name           = "core_network"
  key_vault_name                = "nv-hub-core"
  key_vault_resource_group_name = "nv-hub-core"
  virtual_network_gateway_id    = dependency.vpn_gateway.outputs.virtual_network_gateway.nw-hub-vpn-gw-core.id
  tunnels = [
    {
      name                       = "aws_ireland_dev_tgw"
      local_network_gateway_name = "aws-ireland-dev-tgw"
      routing_table_name         = "aws_ireland_dev_tgw_routingtable"
      secret_name                = "vpn-aws-ireland-dev-tgw-psk"
      gateway_address            = "52.18.92.185"
      address_space              = "10.11.0.0/16"
      address_prefix             = "10.11.0.0/16"
      enable_bgp                 = "false"
    },
    {
      name                       = "aws_ireland_prod_tgw"
      local_network_gateway_name = "aws-ireland-prod-tgw"
      routing_table_name         = "aws_ireland_prod_tgw_routingtable"
      secret_name                = "vpn-aws-ireland-prod-tgw-psk"
      gateway_address            = "52.19.7.38"
      address_space              = "10.21.0.0/16"
      address_prefix             = "10.21.0.0/16"
      enable_bgp                 = "false"
    },
    {
      name                       = "aws_stockholm_prod_tgw"
      local_network_gateway_name = "aws-stockholm-prod-tgw"
      routing_table_name         = "aws_stockholm_prod_tgw_routingtable"
      secret_name                = "vpn-aws-stockholm-prod-tgw-psk"
      gateway_address            = "13.48.37.70"
      address_space              = "10.13.0.0/16,10.23.0.0/16,10.33.0.0/16,10.104.0.0/16,10.22.0.0/25"
      address_prefix             = "10.13.0.0/16,10.23.0.0/16,10.33.0.0/16,10.104.0.0/16"
      enable_bgp                 = "false"
    },
    {
      name                = "azure-to-labs-s2s"
      secret_name         = "azure-to-labs-s2s"
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
    },
    {
      name                = "azure-to-lilje-office-s2s"
      secret_name         = "azure-to-lilje-office-s2s-psk"
      gateway_address     = "98.128.134.222"
      address_space       = "10.245.255.0/30"
      enable_bgp          = "true"
      bgp_asn             = "65407"
      bgp_peering_address = "10.245.255.2"
      dh_group            = "DHGroup14"
      ike_encryption      = "AES256"
      ike_integrity       = "SHA256"
      ipsec_encryption    = "AES256"
      ipsec_integrity     = "SHA256"
      pfs_group           = "PFS24"
      sa_lifetime         = "27000"
    },
  ]
}
