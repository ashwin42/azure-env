variable "resource_group_name" {}

variable "location" {
  default = "northeurope"
}

variable "storage_account_name" {}

variable "stage" {}

variable "virtual_network_address_space" {
  type = "list"
}

variable "gateway_subnet_address_prefix" {}
variable "subnet_address_prefix" {}

variable "gateway_connection_psk" {}
