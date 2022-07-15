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
      display_name     = "NV ViewLinc UMS User Access"
      description      = "Members in this group gets access to UMS ViewLinc cloud setup WVD and VPN"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "NV ViewLinc UMS Administrator Access"
      description      = "Members in this group gets administrator access to UMS ViewLinc cloud setup WVD and VPN"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "NV ViewLinc UMS AP Approvers"
      description      = "Members in this group can approve requests for UMS ViewLinc AP "
      security_enabled = true
      member_users     = []
    },
  ]
}

