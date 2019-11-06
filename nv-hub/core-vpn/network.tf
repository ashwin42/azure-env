locals {
  sn-core-vpn-mgmt-1   = data.terraform_remote_state.core-network.outputs.core_vpn_mgmt_1_id
  sn-core-vpn-client-1 = data.terraform_remote_state.core-network.outputs.core_vpn_client_1_id
}
