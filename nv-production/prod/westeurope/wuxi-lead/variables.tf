// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

variable "name" {
  default = "FLP1PAHTS01KED1"
}

variable "vault_id" {
  default = ""
}

variable "vm_size" {
  default = "Standard_D8s_v3"
}
variable "recovery_vault_name" {
  default = "FL-P1-PA-HTS01-KED01-recovery-vault"
}

variable "recovery_vault_resource_group" {
  default = "nv-wuxi-lead"
}

variable "ipaddress" {
  default = "10.42.0.7"
}

variable "public_ip_address_id" {
  default = ""
}

variable "remote_virtual_network_id" {
  default = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}

variable "backup_policy_id" {
  default = "daily"
}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv-production/wuxi_lead"
  }
}
