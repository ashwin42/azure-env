terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "CMX VPN Eligible"
      description      = "Members in this group can request access to CMX Access Package"
      security_enabled = true
      member_users     = ["johan.nyaker@northvolt.com", "bojan.velichkov@northvolt.com"]
    },
    {
      display_name     = "CMX VPN AP"
      description      = "Members in this group gets access to CMX cloud setup WVD and VPN"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "CMX virtual desktop user access"
      description      = "Members in this group gets access to CMX cloud setup WVD"
      security_enabled = true
      member_users     = []
    },
  ]
}

