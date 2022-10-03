terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.3.1"
  #source = "../../../../../../tf-mod-azuread/app/"
}

include {
  path = find_in_parent_folders()
}

dependency "resource_group" {
  config_path = "../resource_group"
}


inputs = {
  display_name               = dependency.resource_group.outputs.setup_prefix
  group_membership_claims    = ["SecurityGroup"]
  delegate_permission_claims = ["User.Read"]
  enterprise_app_password    = true
}

