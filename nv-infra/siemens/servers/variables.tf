// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv_infra/nv_siemens"
  }
  type = map
}

variable "name" {
  default = "siemens"
}

variable "recovery_vault_name" {
  default = "nv-siemens-recovery-vault"
}

variable "recovery_vault_resource_group" {
  default = "nv_siemens"
}

variable "backup_policy_id" {
  default = ""
}

variable "vm_size" {
  default = ""
}

variable "managed_disk_type" {
  default = ""
}

variable "remote_virtual_network_id" {
  default = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}
