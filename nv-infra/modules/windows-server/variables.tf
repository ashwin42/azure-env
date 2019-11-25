variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "ipaddress" {}

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

variable "managed_disk_type" {
  default = "StandardSSD_LRS"
}

variable "managed_disk_size" {
  default = "80"
}
