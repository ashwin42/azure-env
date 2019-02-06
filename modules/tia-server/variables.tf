variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "ipaddress" {}

variable "password" {}
variable "backup_policy_id" {}

variable "vault_id" {
  default = ""
}

variable "recovery_vault_name" {}

variable "recovery_vault_resource_group" {
  default = "nv-shared"
}

variable "vm_size" {
  default = "Standard_D2_v3"
}

variable "image" {
  default = "/subscriptions/f23047bd-1342-4fdf-a81c-00c91500455f/resourceGroups/nv-automation/providers/Microsoft.Compute/images/tia-template-2019-02-06"
}
