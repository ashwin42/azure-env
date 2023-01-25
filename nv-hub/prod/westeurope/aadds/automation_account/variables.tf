// Vars sourced from inputs (terragrunt.hcl)
variable "resource_group_name" {}

variable "location" {}

variable "log_analytics_workspace_id" {
  default = "279b7294-1937-4b40-a6f3-7ea5127e3dde"
}

variable "repo_tag" {
  type    = map(any)
  default = {}
}

variable "env_tag" {
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

