// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv_infra/nv_siemens"
  }
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
