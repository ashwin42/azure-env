variable "application_name" {
  default = "tia"
}

variable "password" {}

variable "tia_server_count" {
  default = 1
}

variable "tia_vm_size" {
  default = "Standard_D4_v3"
}

variable "tia_data_disk_size" {
  default = 100
}

variable "resource_group_name" {}
variable "subnet_id" {}
variable "subnet_prefix" {}
variable "location" {}
variable "stage" {}
