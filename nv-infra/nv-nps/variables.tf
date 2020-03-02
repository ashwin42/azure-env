// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv_infra/nv_nps"
  }
}

variable "name" {
  default = "nps"
}

variable "vault_id" {
  default = ""
}

variable "recovery_vault_name" {
  default = "nv-nps-recovery-vault"
}

variable "recovery_vault_resource_group" {
  default = "nv_nps"
}

variable "backup_policy_id" {
  default = ""
}

variable "vm_size" {
  default = "Standard_B2s"
}

variable "managed_disk_type" {
  default = ""
}

variable "ipaddress" {
  default = "10.44.3.38"
}

