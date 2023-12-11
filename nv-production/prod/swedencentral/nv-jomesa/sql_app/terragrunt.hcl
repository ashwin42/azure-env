terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.3.6"
  #source = "../../../../../../tf-mod-azuread/app/"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  display_name = basename(dirname(get_terragrunt_dir()))
}

inputs = {
  display_name               = local.display_name
  group_membership_claims    = ["SecurityGroup"]
  delegate_permission_claims = ["User.Read"]
  enterprise_app_password    = true
  tags                       = null
}

