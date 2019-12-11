variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "ipaddress" {}
variable "security_group_id" {}
variable "password" {}
variable "backup_policy_id" {}

variable "secondary_nic" {
  default = ""
}

variable "vault_id" {
  default = ""
}

variable "recovery_vault_name" {}

variable "recovery_vault_resource_group" {
  default = "nv_siemens"
}

variable "vm_size" {
  default = ""
}

variable "managed_data_disk_type" {
  default = "Premium_LRS"
}

variable "managed_data_disk_size" {
  default = "80"
}

variable "image_sku" {
  default = "2016-Datacenter"
}

variable "image_publisher" {
  default = "MicrosoftWindowsServer"
}

variable "image_version" {
  default = "latest"
}

variable "image_offer" {
  default = "WindowsServer"
}

variable "availability_set" {
  default = ""
}
