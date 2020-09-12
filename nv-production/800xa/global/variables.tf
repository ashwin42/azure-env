// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

variable "remote_virtual_network_id" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv-production/800xa/global"
  }
}

variable "recovery_vault_name" {
  default = "LABS-ABB-800xA"
}
