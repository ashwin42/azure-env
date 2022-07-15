// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "subscription_id" {}

variable "name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(any)
  default = null
}
