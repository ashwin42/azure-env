// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv_infra/nv_network_mon"
  }
}

variable "name" {
  default = "nv-network-mon"
}

variable "private_ip_address" {
  default = "10.44.3.4"
}

variable "vm_size" {
  default = "Standard_B2ms"
}

variable "managed_disk_type" {
  default = ""
}

variable "managed_data_disk_type" {
  default = "StandardSSD_LRS"
}

variable "managed_data_disk_size" {
  default = "50"
}

variable "vault_id" {
  default = ""
}

variable "remote_virtual_network_id" {
  default = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}

