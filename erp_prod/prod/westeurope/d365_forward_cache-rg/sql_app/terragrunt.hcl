terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.3.2"
  #source = "../../../../../../tf-mod-azuread/app/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  display_name               = "d365_forward_cache"
  group_membership_claims    = ["SecurityGroup"]
  delegate_permission_claims = ["User.Read"]
  enterprise_app_password    = true
}

