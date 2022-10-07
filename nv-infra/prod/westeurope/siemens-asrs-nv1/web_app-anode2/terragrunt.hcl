terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//web_app?ref=${include.root.locals.all_vars.tf_mod_azure_web_app_version}"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-asrs-web-app.hcl"))
}

inputs = local.common.inputs


