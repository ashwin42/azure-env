terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//web_app?ref=v0.7.32"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-web-app.hcl"))
}

inputs = local.common.inputs
