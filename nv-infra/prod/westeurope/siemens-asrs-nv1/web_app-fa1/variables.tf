variable "subscription_id" {}
variable "resource_group_name" {}

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

variable "module_tag" {
  type    = map(any)
  default = {}
}

variable "location" {}

variable "setup_prefix" {}

variable "environment" {}

variable "subnet_id" {
  default = ""
}

variable "subnet_id2" {
  default = ""
}

