// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

// Locally defined vars
variable "repo_tag" {
  type    = map(any)
  default = {}
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "default_tags" {
  type    = map(any)
  default = {}
}

variable "module_tag" {
  type    = map(any)
  default = {}
}

variable "env_tag" {
  type    = map(any)
  default = {}
}
