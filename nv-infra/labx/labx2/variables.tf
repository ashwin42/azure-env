// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv_infra/nv_labx2"
  }
}

variable "name" {
  default = "labx2"
}

variable "vault_id" {
  default = ""
}

variable "recovery_vault_name" {
  default = "nv-labx2-recovery-vault"
}

variable "recovery_vault_resource_group" {
  default = "nv_labx2"
}

variable "backup_policy_id" {
  default = ""
}

variable "vm_size" {
  default = "Standard_B2ms"
}

variable "managed_disk_type" {
  default = ""
}

variable "managed_data_disk_type" {
  default = "Premium_LRS"
}

variable "managed_data_disk_size" {
  default = "25"
}

variable "ipaddress" {
  default = "10.44.2.8"
}

variable "remote_virtual_network_id" {
  default = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}
