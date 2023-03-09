locals {
  providers                   = ["aviatrix"]
  aviatrix_controller_ip      = "13.53.36.212"
  aviatrix_username           = "admin"
  aviatrix_secret_store       = "secrets-manager"
  aviatrix_secret_aws_profile = "nv-network"
  aviatrix_secret_aws_region  = "eu-north-1"
  aviatrix_provider_version   = "~> 2.24.0"
}
