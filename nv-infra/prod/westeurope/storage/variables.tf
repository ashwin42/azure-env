# Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

variable "subscription_id" {}

variable "default_tags" {
  type    = map
  default = null
}