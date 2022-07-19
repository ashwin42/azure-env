variable "name" {
}

variable "location" {
}

variable "resource_group_name" {
}

variable "subnet_id" {
}

variable "ipaddress" {
}

variable "public_ipaddress" {
  default = false
}

variable "public_ipaddress_name" {
  default = ""
}

variable "password" {
}

variable "backup_policy_id" {
}

variable "vault_id" {
  default = ""
}

variable "dns_zone" {
}

variable "recovery_vault_name" {
}

variable "recovery_vault_resource_group" {
  default = "nv-shared"
}

variable "vm_size" {
  default = "Standard_D2_v3"
}

variable "image" {
  #default = "/subscriptions/f23047bd-1342-4fdf-a81c-00c91500455f/resourceGroups/nv-automation/providers/Microsoft.Compute/images/tia-template-2019-02-06"
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/tia-mu-rg/providers/Microsoft.Compute/galleries/nvgallery2/images/tia-template/versions/0.0.1"
}

variable "ad_join" {
  default = ""
}

variable "subscription_id" {}
