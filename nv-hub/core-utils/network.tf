locals {
  sn-nv_domain_services = data.terraform_remote_state.core-network.outputs.nv_domain_services-id
  sn-core-utils-1       = data.terraform_remote_state.core-network.outputs.core-utils-1-id
}
