variable "resource_group_name" {
  default = "lasernet"
}

variable "location" {
  default = "northeurope"
}

variable "vnet_address_space" {
  type    = "list"
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
