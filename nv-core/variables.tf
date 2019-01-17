variable "resource_group_name" {
  default = "nv-core"
}

variable "location" {
  default = "northeurope"
}

variable "vnet_address_space" {
  type    = "list"
  default = ["10.101.0.0/16"]
}

variable "gateway_subnet" {
  default = "10.101.0.0/27"
}
