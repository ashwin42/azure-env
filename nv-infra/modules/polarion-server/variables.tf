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

variable "vault_id" {
  default = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv-infra-core/providers/Microsoft.KeyVault/vaults/nv-infra-core"
}

variable "recovery_vault_name" {
  default = "nv-polarion-recovery-vault"
}

variable "recovery_vault_resource_group" {
  default = "nv_polarion"
}

variable "backup_policy_id" {
  default = ""
}

variable "vm_size" {
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

variable "security_group_id" {}

variable "managed_data_disk_size" {}
