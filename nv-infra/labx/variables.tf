// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv_infra/nv_labx"
  }
}

variable "name" {
  default = "labx"
}

variable "vault_id" {
  default = ""
}

variable "recovery_vault_name" {
  default = "nv-labx-recovery-vault"
}

variable "recovery_vault_resource_group" {
  default = "nv_labx"
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
  default = "80"
}

variable "ipaddress" {
  default = "10.44.2.7"
}

