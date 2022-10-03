terraform {
  source = "${include.root.locals.all_vars.tf_mod_azuread_path}/app?ref=${include.root.locals.all_vars.tf_mod_azuread_app_version}"
  #source = "../../../../../../tf-mod-azuread/app/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}


inputs = {
  display_name               = dependency.global.outputs.setup_prefix
  group_membership_claims    = ["SecurityGroup"]
  delegate_permission_claims = ["User.Read"]
  enterprise_app_password    = true
}

