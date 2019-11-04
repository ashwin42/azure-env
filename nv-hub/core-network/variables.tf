// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

variable "remote_800xa_vnet" {
  default = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/800xa/providers/Microsoft.Network/virtualNetworks/800xa"
}

variable "remote_csp_vnet" {
  default = "/subscriptions/f23047bd-1342-4fdf-a81c-00c91500455f/resourceGroups/nv-core/providers/Microsoft.Network/virtualNetworks/nv-core-vnet"
}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv-production/core_network"
  }
}
