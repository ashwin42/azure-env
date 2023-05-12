terraform {
  source = "git::git@github.com:northvolt/tf-mod-aviatrix.git//external-device-connection?ref=v0.1.18"
  # source = "${dirname(get_repo_root())}/tf-mod-aviatrix//external-device-connection"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "transit" {
  config_path = "../transit-egress"
}

locals {
  name = "dwa_ipsec_p2_1"
}

inputs = {
  external_device_connection = [
    {
      connection_name           = local.name
      vpc_id                    = dependency.transit.outputs.vpc.vpc_id
      gw_name                   = dependency.transit.outputs.transit_gateway.gw_name
      tunnel_protocol           = "IPsec"
      connection_type           = "bgp"
      ha_enabled                = true
      remote_gateway_ip         = "37.128.85.102"
      backup_remote_gateway_ip  = "37.128.85.103"
      bgp_local_as_num          = dependency.transit.outputs.transit_gateway.local_as_number
      bgp_remote_as_num         = 65362
      backup_bgp_remote_as_num  = 65362
      local_tunnel_cidr         = "169.254.30.10/30,169.254.30.14/30"
      remote_tunnel_cidr        = "169.254.30.9/30,169.254.30.13/30"
      backup_local_tunnel_cidr  = "169.254.35.18/30,169.254.35.22/30"
      backup_remote_tunnel_cidr = "169.254.35.17/30,169.254.35.21/30"
      phase_1_dh_groups         = "14"
      phase_2_dh_groups         = "14"
      phase_1_encryption        = "AES-256-GCM-128"
      phase_2_encryption        = "AES-256-GCM-128"
      phase_1_authentication    = "SHA-256"
      phase_2_authentication    = "NO-AUTH"
      enable_ikev2              = true
      network_domain            = "dwa"
      custom_algorithms         = true
      psk = {
        create_secret = true
        secret_path   = "/vpn/psk"
        secret_name   = local.name
      }
    },
  ]
}
