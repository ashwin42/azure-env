terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.3.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azuread//app"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  display_name               = "asrs-nv1-prod"
  group_membership_claims    = ["SecurityGroup"]
  delegate_permission_claims = ["User.Read"]
  enterprise_app_password    = true
}

