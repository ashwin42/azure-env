// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

variable "remote_virtual_network_id" {
  default = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}

// Locally defined vars
variable "default_tags" {
  type = map
#  default = {
#    repo = "azure-env/nv_infra"
#  }
}
