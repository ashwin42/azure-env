variable "vpn_type" {
  default = "PolicyBased"
}

variable "resource_group_name" {}

variable "virtual_network_name" {}

variable "gateway_subnet" {}
variable "local_network_gateway_id" {}

variable "gateway_connection_psk" {}

variable "location" {}
