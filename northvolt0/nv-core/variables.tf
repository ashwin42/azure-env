variable "resource_group_name" {
  default = "nv-core"
}

variable "location" {
  default = "northeurope"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.101.0.0/16"]
}

variable "vnet_address_prefix" {
  type    = list(string)
  default = ["10.11.0.0/16"]
}

variable "gateway_subnet_prefix" {
  default = "10.101.0.0/27"
}

variable "remote_hub_vnet" {
  default = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}

variable "subscription_id" {
  default = "f23047bd-1342-4fdf-a81c-00c91500455f"
}
