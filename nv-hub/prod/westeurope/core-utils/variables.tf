// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

variable "subscription_id" {}

variable "log_analytics_workspace_id" {
  default = "279b7294-1937-4b40-a6f3-7ea5127e3dde"
}

// Locally defined vars
variable "default_tags" {
  default = {
    repo = "azure-env/nv-production/core_utils"
  }
}
