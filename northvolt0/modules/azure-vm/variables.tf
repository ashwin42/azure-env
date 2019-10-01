variable "application_name" {}

variable "password" {}

variable "server_count" {
  default = 1
}

variable "vm_size" {
  default = "Standard_D4_v3"
}

variable "data_disk_size" {
  default = 100
}

variable "secondary_nic" {
  default = ""
}

variable "resource_group_name" {}
variable "subnet_id" {}
variable "subnet_prefix" {}
variable "base_ip" {}
variable "location" {}
variable "stage" {}
