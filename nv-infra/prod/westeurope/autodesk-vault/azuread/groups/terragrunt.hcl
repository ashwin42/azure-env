terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  groups = [
    {
      display_name     = "NV AutoDesk Vault VPN AP"
      description      = "Used in AP DO NOT EDIT. Members in this group gets access to Autodesk Vault server over VPN"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "NV AutoDesk Vault Server Administrators"
      description      = "Members in this group gets administrator access to Autodesk Vault server"
      security_enabled = true
      member_users     = []
    },
  ]
}

