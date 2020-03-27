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
  default = "preactor"
}

variable "vault_id" {
  default = ""
}

variable "recovery_vault_name" {
  default = "nv-preactor-recovery-vault"
}

variable "recovery_vault_resource_group" {
  default = "nv_preactor"
}

variable "backup_policy_id" {
  default = ""
}

variable "vm_size" {
  default = "Standard_B2s"
}

variable "ipaddress" {
  default = "10.44.5.5"
}

variable "managed_data_disk_size" {
  default = "20"
}

