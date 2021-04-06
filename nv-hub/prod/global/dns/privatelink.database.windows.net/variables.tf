// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "subscription_id" {}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv-production/core_network"
  }
}