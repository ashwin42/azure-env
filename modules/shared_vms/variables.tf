variable "resource_group_name" {
}

variable "application_name" {
}

variable "location" {
    default = "northeurope"
}

variable "virtual_network_address_space" {
    type = "list"
}

variable "subnet_address_prefix" {
}

variable "gateway_subnet_address_prefix" {
}

variable "northvolt_gamla_brogatan_26_local_network_gateway_id" {
}

variable "gateway_connection_psk" {
}