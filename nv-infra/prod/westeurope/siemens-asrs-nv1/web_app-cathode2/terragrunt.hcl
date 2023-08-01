terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//web_app?ref=v0.7.62"
  # source = "${dirname(get_repo_root())}/tf-mod-azure/web_app/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-asrs-web-app.hcl"))
}

inputs = local.common.inputs


