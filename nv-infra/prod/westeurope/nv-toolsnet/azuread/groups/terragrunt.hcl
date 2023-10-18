terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.3.4"
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
      display_name     = "Toolsnet VPN AP"
      description      = "Members in this group gets access to Toolsnet VPN"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "Toolsnet Admin Access"
      description      = "Members in this group gets access to Toolsnet VPN"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "Toolsnet User Access"
      description      = "Members in this group gets access to Toolsnet VPN"
      security_enabled = true
      member_users     = []
    },
  ]
}

