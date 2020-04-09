// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv_infra/nv_polarion"
  }
}

variable "name" {
  default = ""
}

variable "backup_policy_id" {
  default = ""
}

variable "ipaddress" {
  default = ""
}

variable "password" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "recovery_vault_name" {
  default = "nv-polarion-recovery-vault"
}

variable "recovery_vault_resource_group" {
  default = "nv_polarion"
}

variable "vm_size" {
  default = "Standard_B4ms"
}

variable "managed_data_disk_size" {
  default = "500"
}

variable "secondary_nic" {
  default = ""
}