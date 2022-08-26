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
      display_name     = "D365 DRA User Access"
      description      = "Members in this group gets access to D365 DRA cloud setup WVD and VPN"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "D365 DRA AP Approvers"
      description      = "Members in this group can approve requests for D365 DRA AP"
      security_enabled = true
      member_users     = []
    },
  ]
}
