variable "resource_group_name" {
  default = "lasernet"
}

variable "location" {
  default = "northeurope"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.2.1.0/24"]
}

variable "virtual_network_name" {
  default = "lasernet-vnet"
}

# variable "vnet_address_prefix" {
#   type    = "list"
#   default = ["10.11.0.0/16"]
# }

variable "gateway_subnet_prefix" {
  default = "10.2.2.224/27"
}

variable "subscription_id" {
  default = "f23047bd-1342-4fdf-a81c-00c91500455f"
}
