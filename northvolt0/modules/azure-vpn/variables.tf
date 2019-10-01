variable "vpn_type" {
  default = "PolicyBased"
}

variable "resource_group_name" {}

variable "virtual_network_name" {}

variable "gateway_subnet_id" {}
variable "local_network_gateway_id" {}

variable "gateway_connection_psk" {}

variable "location" {}

variable "sku" {
  default = "Basic"
}
